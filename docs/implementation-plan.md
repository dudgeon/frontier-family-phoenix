# **Frontier Family Phoenix – Implementation Plan**

## **Development Methodology**

Given the early-stage status of Frontier Family Phoenix (no features shipped yet and only initial setup in progress), an **Agile iterative methodology** is recommended. Specifically, a lightweight approach like **Kanban with continuous delivery** or **short Scrum sprints** will suit the small team and evolving scope:

* **Iterative Development in Slices:** We will break the project into **vertical “slices”** of functionality that deliver end-to-end value. Each slice will produce a working increment (e.g. a usable feature or infrastructure piece), aligning with Agile principles. This approach allows quick feedback and course correction while gradually building the system.

* **Lightweight Process:** With a small team (possibly 1-3 developers), overhead should be minimal. Daily stand-ups or frequent check-ins, and a Kanban board (or 1-week micro-sprints) to track tasks, will keep everyone synchronized without heavy ceremonies. Work will be pulled from the backlog as ready, ensuring continuous flow.

* **Frequent Integration:** Every code change will go through the CI pipeline for testing and automated deployment. The monorepo setup and CI/CD (via GitHub Actions \+ Netlify) supports rapid integration – e.g. every pull request can spin up a preview environment with its own database instance. This enables testing each slice in isolation and merging quickly once it passes quality checks.

* **Adaptability:** As the team learns more about user needs (parents and children) and technical constraints (AI model behavior, content filtering efficacy), the methodology allows adapting the plan. For example, if a certain feature proves complex, we can reprioritize upcoming slices or add a spike (research task) to investigate solutions. The process supports responding to change, crucial for an innovative project exploring safe AI for kids.

Overall, an Agile mindset will help **deliver a functional MVP quickly**, then iterate on improvements. The focus is on continuous delivery of small features, close communication, and maintaining flexibility – ideal for a project of this scope and early progress.

## **Key Project Documentation**

To ensure clarity and maintain momentum, we will create and maintain several documents throughout the project. These will guide development decisions and onboarding as the team grows:

* **Product & Planning Documents:**

  * **Product Requirements Document (PRD):** A living document capturing the project vision, target users (parents and children), and MVP feature set. It will detail what “safe, tailored access” means in practice for our chat assistant, user scenarios (e.g. a child asking homework questions, a parent reviewing interactions), and success criteria for the MVP.

  * **User Stories & Backlog:** A list of user stories or use cases broken down by feature slice. For example: “As a child, I want to ask the AI a question and get a friendly answer,” or “As a parent, I want to see what questions my child is asking.” These stories feed into the Agile backlog, prioritized for each iteration.

  * **Project Roadmap:** A high-level timeline outlining development phases (from infrastructure setup through MVP launch). This gives stakeholders a sense of sequencing (see the “Development Roadmap & Sequencing” below) and highlights key milestones (e.g. completion of CI/CD, basic chat demo, user accounts, etc.).

* **Technical Design Documents:**

  * **Architecture Overview:** A detailed design doc describing the system architecture. This will include diagrams and explanations of the **monorepo structure** (multiple apps and shared packages), the integration of **Supabase (backend DB/auth)**, **Netlify (web hosting)**, and **Expo (mobile app)**. It will outline how the front-end(s) communicate with the backend (e.g. using Supabase client libraries or REST endpoints) and how AI model calls are made (likely via an external API call to OpenAI or similar from a serverless function).

  * **Architecture Decision Records (ADRs):** For each major tech decision, we will write a short ADR. Examples: choice of using Supabase (BaaS) instead of a custom Node.js server, decision to use a monorepo and Expo for cross-platform development, selection of OpenAI GPT-4 as the initial AI model, or how to implement content filtering. These ADRs document the reasoning and alternatives considered, helping future contributors understand why certain choices were made.

  * **API Contracts & Integrations:** Documentation of any APIs the system exposes or consumes. This includes **API contract docs** for serverless functions or endpoints (for example, if we create Supabase Edge Functions or Netlify Functions for the AI chat, we’d document their request/response format). Also, documentation for third-party integrations: e.g. how we call the OpenAI API (endpoint, parameters, usage of API keys) and any wrappers/utilities in the code for AI interaction.

  * **Data Model & Schema Docs:** A reference for the **database schema** in Supabase. We’ll maintain an ER diagram or table-by-table description of the data structures: user profiles (parent/child), chat messages or conversation records, content moderation logs, etc. This document will evolve with the Supabase migrations. (Since migrations are in the repo, this doc ensures everyone understands the data model.) If using Row-Level Security (RLS) in Supabase to separate parent vs child data access, that will be described here too.

  * **AI Safety & Moderation Policy:** A specialized document defining how we ensure the chat is family-friendly. It will include the **content filtering strategy** – e.g. using OpenAI’s moderation endpoint or a custom filter list – and guidelines for prompt design to keep the AI responses age-appropriate. This doc might list categories of disallowed content (violence, adult topics, hate speech, etc.) and how the system responds if such content is detected (maybe the assistant says it cannot answer that). This acts as both an internal design guide and an external policy reference. (Other family AI products emphasize such safety controls, so we will clearly document our approach as well.)

* **Project Onboarding & Process Documents:**

  * **Developer Onboarding Guide:** While the README provides basic setup instructions, we will expand this into a detailed onboarding doc for new team members. It will cover environment setup (e.g. installing the Supabase CLI and running supabase start for a local dev DB), how to run the web app and mobile app in development, and how to run tests. It will also include any gotchas or tips (for instance, how to set up the required .env variables or obtain API keys for dev).

  * **Contribution Guidelines:** A document outlining code style, branch strategy, and CI expectations. For example, our repo has ESLint config – we’ll note the coding style rules and any naming conventions. We’ll also describe the process for feature branches and pull requests, including the requirement that **new code must include tests** (as mentioned in the README, aiming for 80% coverage). This ensures consistency as the team grows and that every contributor follows the quality standards.

  * **CI/CD Pipeline Documentation:** An outline of our continuous integration and deployment setup. We will document the GitHub Actions workflows (in .github/workflows) that run tests, lint, etc., and how previews are deployed. The pipeline uses Supabase CLI and Netlify for branch previews – we’ll explain that process: e.g. “On each PR, the action will create a new temporary database branch on Supabase and deploy a preview site on Netlify pointing to that DB.” We’ll list what secrets are needed (SUPABASE\_ACCESS\_TOKEN, NETLIFY\_AUTH\_TOKEN, etc., as already noted in the repo) so that if the CI breaks or a new environment is set up, it’s clear how to configure it.

  * **Test Plan & QA Strategy:** A brief test strategy document. This will describe the testing levels (unit tests for logic, integration tests perhaps for the functions and DB via Supabase’s testing capabilities, and manual end-to-end testing for the UI). We will state the goal of maintaining high coverage (≥80%) and possibly mention use of any testing tools or generation scripts (the README mentions a gen:test script to scaffold tests – the doc can guide how to use such utilities). Additionally, as we get closer to release, we might outline a QA checklist for the MVP (covering security tests, performance on various devices via Expo, etc.).

  * **User Guide / FAQ (MVP Launch):** Although more relevant at release time, we plan to prepare a simple user guide for the MVP – likely as a Markdown in the repo or a webpage. It will explain to parents how to create an account, how to add their child (if that feature exists by MVP), and how to use the chat safely. It may also outline the limitations (e.g. “the AI might refuse some questions due to safety filters”). Having this documentation ensures that early users (and stakeholders) can understand and properly use the product from day one.

Each of these documents will be kept up-to-date as the project evolves. Early on, the **PRD and Architecture Overview** are top priority to align the team on what we’re building. As development proceeds, **ADRs** and design docs will capture key changes (for example, if we decide to add another AI model or switch how we do authentication). By MVP delivery, we aim to have not just working code, but also a clear paper trail of decisions and guides – making the project maintainable and ready for handoff or onboarding of new developers.

## **Development Slices and Initial Product Specs**

We will implement the project in a series of **development “slices,”** each representing a coherent set of functionality. Below, we define each slice with its objectives and specifications. The slices are ordered logically – beginning with infrastructure/setup (to enable efficient development), then building up the core features needed for a usable MVP. Each slice’s “product spec” outlines what will be delivered (from both a user perspective and a technical perspective):

### **Slice 1: Complete Repository Setup & CI/CD Pipeline**

**Objective:** Finalize the project’s foundational setup so that development is smooth and reliable. At the end of this slice, all team members should be able to develop and contribute with confidence that the system will catch issues early and deploy working code automatically.

**Scope & Tasks:**

* **Repository Structure Completion:** Ensure the monorepo is properly organized and documented. This includes verifying all sub-folders (apps, packages, functions, etc.) are in place and linked via the package manager (likely npm workspaces or pnpm). Any placeholder or “dummy” directories (e.g. dummy-functions) will be reviewed and either removed or fleshed out with initial code. The goal is that the repo structure matches the needs of web, mobile, and backend code all in one place, and new files can be added without friction.

* **Linting, Formatting, and Hooks:** Configure ESLint (and Prettier if used) properly. The presence of .eslintrc.cjs and .eslintignore was noted in recent commits, so we will finalize those rules. We will also set up any git hooks (using Husky or simple npm scripts) to run linting and tests pre-commit or pre-push, to maintain code quality. All existing code (if any from the bootstrap) will be made to pass linting.

* **CI Pipeline Configuration:** Finish setting up GitHub Actions workflows for testing and deployment. We will likely have workflows such as:

  * **CI Build/Test:** On each push or PR, install dependencies and run npm test (ensuring that includes running our unit tests and perhaps building the apps). We’ll integrate coverage reporting here (maybe using a service or simple summary) so that we can enforce the 80% coverage target.

  * **Preview Deployments:** Configure the workflow to interface with Supabase and Netlify for preview environments. For example, when a PR is opened, use the Supabase CLI to create a new **branch database** (so the preview has an isolated DB) and deploy the frontend to Netlify’s preview URL pointing to that DB. This requires that the repository secrets (SUPABASE\_ACCESS\_TOKEN, NETLIFY\_AUTH\_TOKEN, NETLIFY\_SITE\_ID) are in place – part of this slice is to generate/acquire those tokens (likely from the project owner’s accounts) and add them securely to GitHub. We will test this by opening a dummy PR and verifying that the deploy succeeds and is accessible.

  * **Main Branch Deployment:** Also ensure that merging to main triggers a deployment of the production/staging site (depending on branching strategy). Likely, Netlify is configured via netlify.toml for the production build. We’ll verify that a commit to main deploys the latest web app and that it can talk to either a production Supabase instance or the local one. (We may still be using local Supabase for development, but for deployed previews and prod we might have a cloud Supabase project set up – that needs to be confirmed and documented.)

* **Basic Monitoring in CI:** (Optional small task) Add error reporting or status badges. For instance, set up a badge in the README for build status and test coverage. Also consider integrating Dependabot for dependency updates, since the project is new – ensuring the CI will catch any breaking updates.

**Expected Outcome:** By the end of Slice 1, the project infrastructure is solid. New developers can clone the repo, run npm install and npm run dev to get started, as documented in the README. The CI pipeline will automatically verify code quality and deploy previews, lowering the risk of integration issues. This slice does not deliver user-facing features, but it is crucial groundwork before we start building the actual product.

### **Slice 2: Basic Chat Interface & AI Integration (MVP Core)**

**Objective:** Deliver the first working end-to-end feature: a simple chat interface where a child (or parent) can ask questions and get answers from an AI assistant. This slice establishes the core functionality of the app as a **chatbot**.

**User Story:** *“As a child user, I want to ask the AI assistant a question and receive a helpful, age-appropriate answer in a chat interface. The experience should be simple and friendly, like chatting with a helpful tutor or friend.”* (Initially, we assume the child can use the app under supervision, since full parental controls come later. The interface should be easy to use for a school-age kid.)

**Scope & Features:**

* **Chat UI (Web):** Implement a minimal web-based chat UI. This will likely be a single-page view with:

  * A scrollable chat history area showing messages (with distinctions between user queries and AI responses).

  * An input box where the user can type a question and send it.

  * Basic styling to make the interface kid-friendly (large fonts, maybe some playful design elements) but nothing too elaborate yet. The focus is functionality.

  * The UI will be implemented in the web app (possibly a React or Next.js app in apps/web). We’ll also ensure the front-end can connect to the backend or directly to the AI API as needed.

* **Backend Function for AI Query:** Implement the core logic to handle a user’s question by querying the AI model. There are a couple of approaches:

  * **Direct from Frontend:** The web app could call the OpenAI API directly (using the OpenAI JS client or REST call) if we expose the API key. However, exposing a key in a client is not secure. Instead, we will likely create a **serverless function** (either a Netlify Function or a Supabase Edge Function) that the front-end calls. This function will accept the user’s question, add any system instructions (e.g. “You are a friendly assistant for kids.”), then call the OpenAI API (or another model) on the server side, and return the result.

  * We will implement this function in the functions/ directory of the monorepo. A dummy function might exist already; we will replace it with a real implementation that calls the model. Initially, use a single **leading AI model** (likely OpenAI GPT-3.5 or GPT-4) as the backend for all queries.

* **Basic AI Prompting:** As part of the AI integration, craft a simple system prompt to ensure the AI’s tone is appropriate for kids. For example: *“You are a helpful, polite assistant for children. Keep your answers friendly, encouraging, and age-appropriate.”* This will guide the model’s output. This is a first step toward “tailored access” for kids. We might iterate on this prompt based on testing.

* **No Persistence Yet (or Basic Persistence):** At this stage, we may or may not implement saving chat history to the database. If user accounts are not yet in place (they come in a later slice), we might just keep the conversation in memory on the client for now. However, to prepare for the next slices, we could set up a Supabase table for messages and store chats with a temporary user/session ID. For MVP, storing history is less critical than the real-time interaction, but it might be trivial to implement. We’ll decide based on effort:

  * If quick, create a messages table (with fields: id, user\_id (nullable for now), role (user/assistant), text, timestamp, etc.) and insert each Q\&A. This way we don’t lose the conversation if the page reloads and we’ll have data ready when accounts are introduced.

  * If time is tight, we skip persistence until accounts are done, and simply keep conversation state in the React component state.

* **Testing & Demo:** Once implemented, we’ll test with some sample queries (e.g. “What is 2+2?”, “Tell me a fun fact about space.”). We expect the AI to respond with correct and cheerful answers. We’ll verify that the end-to-end path works: user input → API call → AI response → displayed in UI. This slice essentially delivers a **proof of concept** of the core chatbot functionality.

**Expected Outcome:** Slice 2 produces the first visible product: a working chatbot on the web. A child (or test user) can interact with it and get answers. At this point, it’s still **basic** – there are **no explicit safety filters** beyond what the AI model inherently does, and **no user login**. Those will come next. But this slice is a huge milestone: we prove that our stack (web app \+ serverless function \+ AI API) works together to fulfill the primary use-case of answering questions.

### **Slice 3: Content Moderation & Safety Filters**

**Objective:** Incorporate robust content filtering to ensure the chat remains **family-friendly and safe** for kids. This slice builds the “guardrails” around the AI, implementing the promise of **safe, tailored access** to AI. We will prevent inappropriate content from reaching the child, and handle such cases gracefully.

**User Story:** *“As a parent, I want the AI assistant to **block or sanitize any inappropriate content**, so that I can trust my child is not exposed to harmful information.”* Even though the child might be the one directly using the chat, this feature serves the parent’s peace of mind and aligns with parental controls.

**Scope & Features:**

* **Moderation API Integration:** We will integrate with OpenAI’s Moderation API (or a similar service) to automatically check the content of AI responses (and possibly user queries too). The flow will be:

  * When the child sends a question, optionally run it through moderation first. If the question itself is disallowed (e.g. it asks for something explicit), we can intercept.

  * After getting the AI’s answer, definitely run the answer through moderation. If it’s flagged as containing disallowed content (hate, sexual content, self-harm, etc.), **do not show it to the child**.

  * OpenAI’s moderation returns categories and a flag; we’ll use that to decide. For MVP, we can enforce a simple policy: if any flag is true (or above a certain threshold), we treat the content as unsafe.

* **Define Content Rules:** In addition to the automated moderation, we may implement our own **rule-based filters**. For example, maintain a list of forbidden keywords/slurs that we always censor out or block, to cover edge cases. This can complement the moderation API. (This list and rules will be documented in the AI Safety doc.)

* **Safe Response Handling:** Determine how the system responds when content is blocked:

  * For a disallowed **user question**: The assistant can reply with a gentle refusal like “I’m sorry, I can’t help with that topic.” This uses the AI but with a prompt that enforces a refusal.

  * For a disallowed **AI answer** (should be rarer if the prompt and model are good): Instead of showing it, we might replace it with a generic apology (“Oops, I can’t answer that.”) or try a second attempt with a stricter prompt. We’ll implement at least the former for MVP – ensuring the child never sees the improper answer.

  * We will test scenarios to ensure even if the model *attempts* to output something banned, the child doesn’t see it.

* **Logging and Flags:** Internally, we will log any moderated event. For example, if a query/response was blocked or sanitized, we record that (maybe in a moderation\_logs table with fields: message\_id, flag\_reason, timestamp). This will be useful later for parental monitoring (a parent could review that something was blocked) and debugging our system.

* **UI Feedback:** Update the UI to handle moderated cases. If the child’s question is not answerable (e.g. “How do I make a bomb?”), the assistant’s response might just be a brief refusal. The UI should display that as a message from the assistant. We might also consider showing a softer explanation like “This question can’t be answered.” Similarly, if the child types something truly not allowed, we could even prevent sending it (e.g. if we decide to client-side block certain words). For now, a simple server-side block with a polite response is fine.

* **Testing the Filters:** Create test cases for various categories:

  * Mild scenario (should pass): “What’s a good movie for kids?” – answer should come through.

  * Boundary scenario: “Tell me a scary story with some violence.” – The AI might attempt something with violence; ensure our filter decides appropriately (maybe mild cartoon violence is ok? We might adjust thresholds).

  * Disallowed scenario: explicit content request – ensure it’s blocked and the response is a refusal.

  * We’ll also intentionally try to get the AI to output something disallowed (with a special prompt in a test environment) to verify our moderation catches it.

**Expected Outcome:** After Slice 3, the chatbot is **significantly safer**. We have a moderation layer active such that both user inputs and AI outputs are monitored and filtered. This differentiates our product from a vanilla AI chatbot – fulfilling the “kid-safe” requirement. Parents (and our team) can be confident that the chance of inappropriate content slipping through is minimal, and any attempts are logged. In practice, the child might not even notice this layer except that the assistant might refuse certain requests politely. This sets the stage to let children use the app more freely, paving the way for real usage.

### **Slice 4: User Authentication and Profile Management**

**Objective:** Introduce **user accounts** into the system, laying the groundwork for parental control features. We need a way to distinguish parents from child users and to persist user-specific data (like chat history per user, and settings). This slice implements signup/login and basic profile info using Supabase’s authentication service.

**User Story:** *“As a user, I want to create an account and log in, so that my chat history and preferences can be saved and (if I’m a parent) I can manage my family’s usage.”* For a child user, an account will eventually allow linking with a parent account for oversight.

**Scope & Features:**

* **Supabase Auth Integration:** Utilize Supabase’s built-in auth (email/password to start with) to allow account creation. We’ll add a **Sign Up** and **Log In** interface to the app:

  * The Sign-Up form will collect basic info: email, password, and perhaps the user’s name. We might also ask, “Are you a parent or a child?” as a checkbox or dropdown. (If we don’t want to expose that choice, we could assume all sign-ups are parents by default, and add children differently – but a direct selection could speed up testing roles.)

  * On form submission, use the Supabase JS client to register the user. Supabase will handle password hashing and email verification (we can decide if we require email confirmation or skip it for MVP).

  * The Log-In form will authenticate existing users similarly.

  * Manage auth state in the app (store the session/token, etc.). Supabase provides libraries to help with this.

* **User Roles & Profile Data:** Extend the database to distinguish user types:

  * Create a profiles table (if not already from Supabase quickstart) that has user\_id (PK referencing Supabase auth user), name, and a role (e.g. ‘parent’ or ‘child’), plus maybe an age or child’s age if applicable.

  * If a user signs up and indicates they are a parent or child, set the role accordingly in this table. For MVP, we might restrict that only parents can sign up directly (and children accounts are created by parents in the next slice). But to keep it simple, we might let anyone sign up, then handle linking later. We’ll decide: one approach is **invite-only child accounts** (parent invites child via email). That might be too complex for MVP, so perhaps allow child sign-up but require a parent code – which we likely won’t have time for. Thus, likely path: initial sign-ups are parents, and we implement child creation in slice 5\.

  * The **role field** will be important for controlling access (for example, only parents will see the forthcoming admin dashboard). We’ll enforce role checks in the UI and possibly with Supabase RLS rules on certain data (e.g. parent can read child’s messages, child can only read their own).

* **Attach Chat Data to Users:** Now that users exist, modify the chat backend to **associate messages with a user ID**:

  * If we created a messages table earlier without user context, alter it to add user\_id (foreign key to auth user). Or if we held off on storing chats, implement it now: each message (question or answer) stored in the DB with the user’s ID (for answers, store the user as the one who initiated it, plus maybe a flag that it’s assistant’s message).

  * This allows saving conversation history per user. For MVP, we might not have a UI to view past chats yet, but data retention is useful for future features (and for parental monitoring).

  * Ensure that any Supabase calls or serverless functions now require an authenticated user. For example, our chat function might need the user’s JWT to write to the DB. We’ll test that the flow works with an authed context.

* **UI Adjustments for Auth:** Introduce a basic account UI:

  * Show a login/register screen for non-logged-in visitors. Possibly use a simple routing (if using Next.js or a React router) to protect the main chat page behind login.

  * Add a nav bar or menu with options like “Logout”, and maybe “My Account” for future settings.

  * When logged in, display the user’s name (“Hello, Alice\!”) to personalize.

* **Onboarding Flow:** Consider how a child user will log in. If we decide only parents create accounts at this stage, then initially only parent accounts exist. But let’s assume for completeness that a parent could create a child’s credentials and give them to the child. We will not fully implement that until next slice, so for now, possibly only one type of user (parent) uses the system. That’s fine for MVP baseline, since a parent could always log in and then have the child use it under supervision.

* **Security:** Use SSL (Netlify will handle that) and secure storage for the auth token (likely localStorage or cookies via Supabase). Ensure we don’t expose anything sensitive on the client. Also, test basic auth error cases (wrong password, etc.) to make sure the UX is okay.

**Expected Outcome:** After Slice 4, the application supports **user accounts and login**. The system knows who is using it. While this doesn’t yet unlock full family features, it’s a critical step: it means we can persist data per user and build parent-child relationships. A parent user can now log in and trust that their data (and eventually their kids’ data) is private to them. From here, we can implement actual parental control features in the next slice. Importantly, by having auth in place, we also set the stage for deployment – if we were to release the MVP at this point, we could manage access and start collecting feedback from a small group of test users securely.

### **Slice 5: Parental Controls and Family Management**

**Objective:** Implement the features that allow a parent to manage the family’s usage of the AI assistant – the defining features that make the product *“family friendly”* beyond just safe AI. This includes the ability for a parent to create child accounts (or profiles), supervise their activity, and configure certain restrictions.

**User Story (Parent):** *“As a parent user, I want to **manage my child’s access** – for example, create a login for my child, set age-appropriate content settings, and review what questions they ask – so that I have peace of mind about their use of the AI assistant.”*

**Scope & Features:**

* **Child Account Creation:** Provide a way for a parent to create one or more child accounts under their supervision. Possible implementation:

  * In the parent’s account section, add a **“Add Child Profile”** form. The parent can input a child’s name, age, and an email or username for the child. We then create a new user in Supabase for the child:

    * One approach: use Supabase Admin privileges (we might need an admin service key) to call an API that creates a user with a temporary password, then email it. This might be too much for MVP.

    * Simpler: we could allow the child to sign up normally (with their own email), but then require a parent code to finalize. Alternatively, treat child profiles not as separate logins initially, but as sub-users under the parent’s login (like profiles on Netflix). That avoids separate authentication for the child in MVP.

  * For MVP simplicity, we might choose the **“profile under parent account”** model: The parent can create a profile that the child uses on the same device/app without a separate login. In practice, the app could allow switching profiles (like “Login as Parent” vs “Login as Kid” under the same account). This might be simpler than building multi-user linking in the backend. We will document whichever approach we take in the design doc. The key is to represent that child in the data model:

    * If using sub-profiles: have a child\_profiles table with an ID, parent\_id (link to parent’s user id), child name, age. No separate auth users for child, the child will effectively use the parent’s auth but with a profile selector (less secure, but okay for MVP since parent presumably controls the device).

    * If we attempt separate auth for child: then we must link the child’s auth user id to a parent’s id in a relationship table. This is a bit more complex but more real-world. We might simplify and not fully implement invites – maybe just manually link via database for now.

  * Due to time, the sub-profile method might be the one to implement for MVP, and we can note to transition to true separate accounts later.

* **Parental Dashboard:** Create a section in the web UI for parents to oversee usage:

  * **View Chat History:** Allow a parent to see transcripts of what their child has been asking and the answers given. If we did sub-profiles, those chats might be stored with a profile identifier. If separate accounts, we fetch child’s messages via an authorized route. For MVP, a simple implementation: when a parent profile is active, show a list of all messages from all their linked child profiles (or just from that account if we didn’t separate). This can be a basic list or perhaps grouped by session.

  * **Monitoring Alerts:** If any content was flagged by the moderation system (from Slice 3\) as attempted inappropriate, surface that to the parent. For instance, highlight messages that were blocked or that triggered flags, so the parent is aware of any concerning attempts. This can be as simple as marking them in the history view (e.g. “Child tried to ask X, which was blocked.”).

  * **Settings Control:** Provide a couple of configurable settings the parent can adjust:

    * **Content strictness level:** Perhaps an option to set the maturity level (e.g. “child mode” vs “teen mode”). In child mode, the assistant might be more restrictive or simpler in responses; in teen mode, maybe it can handle slightly more advanced topics. For MVP, even a boolean “Strict Mode” toggle could be implemented (tied to how we use the moderation API – maybe set different thresholds or allow certain categories when off). This gives the parent some agency in tailoring the AI’s behavior.

    * **Usage limits:** Optionally, a setting like maximum questions per day to prevent overuse. We might not enforce this in MVP, but putting a placeholder in the UI or just noting in docs as future.

    * **Time-of-day access:** Possibly out of MVP scope, but as a note, parents might want to restrict usage to certain hours. We likely won’t implement this now, but it can be noted as a future feature. For now, we assume the parent will supervise and not need a technical block.

  * **Profile Management:** List the child profiles/accounts with ability to edit or deactivate them. If a child leaves the family or should lose access, the parent can disable their profile (maybe setting a flag in DB). MVP could skip deletion and just allow creation, but we should at least allow removing a profile for completeness.

* **Mobile App Consideration:** If the child will use a tablet/phone, the parent dashboard might primarily be on the parent’s device. We should ensure the parent features are available on web (or at least accessible via a desktop browser). We’ll plan to have parity on mobile for core chat, but the admin interface might remain web-first for MVP due to complexity. (We will mention mobile in next slice.)

* **Authorization & Security:** Enforce rules:

  * Only a parent user can access the dashboard and create profiles. If using sub-profiles under one auth, we check an attribute (role) and unlock the dashboard.

  * If using separate accounts, ensure that a child cannot call the APIs that fetch someone else’s data. Supabase RLS rules can be set: e.g. a message can be read by its owner or that owner’s parent (we can use foreign keys and RLS policies to enable that). This might be advanced, but we’ll implement at least basic checks in our serverless functions: if a user tries to fetch logs that aren’t theirs and they’re not listed as parent, deny.

  * The moderation logs or flagged content should similarly only be visible to the parent, not the child.

* **UI/UX:** Design the dashboard UX to be simple and clear. Possibly a separate page or a modal:

  * “Family Settings” page: shows parent’s own info and a list of children.

  * “Add Child” button and list of children with basic info.

  * Clicking a child could show their chat history and maybe allow the parent to replay a question or copy it (mostly for oversight, not needed to interact).

  * If time permits, maybe allow the parent to share a good Q\&A from the child on social or save it – nice-to-have, not core.

  * Ensure the style remains friendly and not intimidating; use approachable language (e.g. “Your Family” section).

* **Testing:** We will test the full parent-child flow:

  * Parent creates a child profile “Tom (age 10)”.

  * Simulate using the app as Tom (maybe by a profile switch or logging in as the child if separate). Ask a few questions.

  * Then log back as parent and confirm those questions appear in history, and any settings toggles work (e.g. turning on stricter mode perhaps blocks something that was allowed before).

  * We’ll test that children (or unauthorized users) cannot access the parent dashboard or any other child’s data by direct URL or API call.

**Expected Outcome:** Slice 5 delivers the **family management features** that differentiate Frontier Family Phoenix as a parent/child oriented product. A parent can now have multiple child profiles under their account, and actively supervise their usage: they can review what the kids are asking and control certain aspects of the AI’s behavior. This fulfills the product promise of a “parent/family friendly chat assistant” by not only making the AI safe (from slice 3\) but also giving control to the parent. By the end of this slice, our MVP’s feature set is essentially complete: safe AI chat for kids, with parental oversight.

Depending on project scope, this might be the point of an MVP release (if web-only). We would have: a working chat with safety, accounts, and parental controls. One remaining aspect to address would be making the solution available on devices kids use – hence, the mobile app.

### **Slice 6: Cross-Platform Client (Expo Mobile App)**

**Objective:** Leverage the Expo setup to deliver a **mobile version** of the chat application, so that kids can use the assistant on tablets or phones, and parents can possibly use it on mobile as well. The goal is to reuse as much code as possible from the web app to have feature parity on mobile.

**Scope & Features:**

* **Mobile App UI:** Using Expo (React Native), implement the chat interface in a native mobile UI. This likely involves:

  * Creating screens for Login, Chat, and Parent Dashboard similar to the web versions.

  * If we planned correctly, a lot of the business logic (API calls, state management, etc.) can reside in shared packages so the mobile and web can use them. We will create a shared library (in packages/) for things like API client code (for calling our functions or Supabase) and perhaps for UI components that can be shared (using React Native Web for web, or conditionally rendering).

  * Ensure the design is responsive and touch-friendly. The chat view on mobile might use a similar list for messages. We might incorporate some mobile-specific features like the keyboard handling or the ability to use voice input (if time allows, voice input could be a cool feature for kids, but it might be an enhancement post-MVP).

* **Account Integration:** The mobile app will use the same Supabase auth. Expo has support for secure storage of tokens. We’ll set up the app to allow a user (likely the parent setting it up for the child) to log in with their email/password.

  * If using sub-profile model: the parent logs in on the app and then selects which profile (themselves or child) is using the app this session. For example, a parent could hand the phone to the child in “child mode” profile. We might implement a simple profile switcher UI on the app home screen.

  * If separate accounts: the child can directly log in with their email/password (provided by parent). In that case, we might actually publish two apps or modes, but that’s overkill; better to allow either user type to log in and then branch logic (child login goes straight to chat, parent login goes to either chat or dashboard).

* **Parity of Features:** Ensure all core features from web are present:

  * Chatting (with the same AI backend).

  * Moderation still applies (should if it’s done server-side).

  * If parent, ability to view child transcripts and settings. Perhaps the dashboard on mobile is a bit simplified but should at least show the key info and allow adding a child.

  * If push notifications are desired (for example, notify parent when a child’s question was blocked), that could be a future feature (not in MVP). We note it but not implement now.

* **Testing on Devices:** Use Expo’s emulators or physical device testing to ensure the app runs smoothly on Android and iOS. Check layout for different screen sizes. Test login flow and a chat query on mobile to verify end-to-end connectivity (the app should communicate with the same backend).

* **Deployment (if MVP includes mobile release):** If we aim to release the app, even as a beta, set up the build process:

  * Use Expo’s EAS build service to compile the app for iOS and Android.

  * Possibly plan for TestFlight (iOS) and an Android APK for internal testing. Publishing to app stores might be beyond MVP timeline, but having the app ready is important.

  * Ensure the Netlify web app and the mobile app can coexist (they share backend and database). We might have CORS or URL issues to configure if the mobile app calls our cloud functions directly (we’ll fix those as needed).

**Expected Outcome:** By completing Slice 6, Frontier Family Phoenix is accessible across platforms: web and mobile. This maximizes convenience – kids can use a tablet or phone which is often more accessible for them than a laptop browser, and parents can manage on-the-go. While the **web app could suffice for an MVP**, having a mobile app (even if not widely released yet) is a strong step toward the final product vision. It shows that our architecture (Expo \+ monorepo) pays off in code sharing and rapid multi-platform development. After this slice, we would conduct a thorough end-to-end test: a parent creates an account on web, adds a child, the child logs in on the mobile app and chats, parent sees it on their mobile dashboard, etc., ensuring everything works seamlessly in the ecosystem.

## **Development Roadmap & Sequencing**

Bringing it all together, below is the logical sequence of development stages from infrastructure setup to delivering the MVP:

* **Phase 0: Planning & Setup (current stage)** – *Establish foundations*. Complete the repository and CI/CD setup (**Slice 1**). Also in this phase, finalize the product spec and architecture documents so the team has a clear blueprint. The project is already a monorepo with initial CI, so this phase is about finishing those integrations and making sure the team can hit the ground running with development.

* **Phase 1: Core Functionality** – *Build the basic chat capability*. Implement the chat UI and connect to the AI model backend (**Slice 2**). Immediately after, implement content moderation for safety (**Slice 3**). These two slices together deliver a working, safe chat experience. By the end of Phase 1, we could demonstrate the basic product: a single-user chat that gives kid-friendly answers and filters out bad content.

* **Phase 2: User Accounts & Roles** – *Enable multi-user and family context*. Introduce authentication and profiles (**Slice 4**) so that each user has an account (parent or child). Follow that by adding the parental control features and child management (**Slice 5**). This phase makes the product multi-user and tailored for family use. After this, we have a fully functional MVP: a parent can sign up, let their child use the chat under that account, and supervise the usage through provided tools.

* **Phase 3: Cross-Platform Delivery & Polish** – *Extend to mobile and refine for MVP launch*. Implement the mobile client via Expo (**Slice 6**), ensuring feature parity. Simultaneously, do final polishing: improve UI consistency, fix any usability issues discovered in testing, and update documentation (especially the user guide and any remaining TODOs in docs or ADRs). Finally, perform an end-to-end QA of the entire system across devices.

* **MVP Launch:** Once the above phases are complete and tested, we will have an MVP ready to deploy to real users. The MVP will include:

  * A secure web application (hosted on Netlify) for the Frontier Family Phoenix chat assistant,

  * A companion mobile app (for internal testing or limited release initially),

  * Key features: AI chat with leading model(s), robust content filtering, user accounts with parent/child roles, and a basic parental dashboard for oversight.

After MVP launch, the team can gather user feedback (from parents and kids in a pilot group) and iterate further. Future phases might include enhancements like integration of multiple AI models (letting the system use different models for different queries), more nuanced parental controls (detailed time limits, educational content modes), and perhaps a subscription or premium model (if relevant). But those are beyond the MVP scope.

In summary, the implementation plan above provides a structured path from the current nascent repository to a feature-rich MVP. By following this plan – using an Agile approach, maintaining thorough documentation, and building in logical slices – the Frontier Family Phoenix team can incrementally achieve their vision of a **family-friendly AI chat assistant** that offers kids a safe, tailored AI experience with parents in control. Each stage builds upon the last, reducing risk and ensuring that at any point we have a working product that we can demonstrate and validate. This approach will help the team ship the first version confidently and set the stage for future growth and improvements.
