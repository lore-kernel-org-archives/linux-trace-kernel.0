Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704147DF95
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523934; cv=none; b=DPsK45Tv3VjcZJ1d9xmspJ17fQHxrh0AeB+cIQ/DGta2XSPAUdM5BQpyPDOmvkEDeEFHrJyuh1NrCTMOrNFJ5Y6f3nEbCIzJT18IklcoQKr7hrAgERHOZZxsucLTzzaK7RYlwnf44i/1yKAWO+hizbW7O86YHzTE6XRxz2CDh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523934; c=relaxed/simple;
	bh=1US6IxmZ7Cw2Pv456ZtYpFmro3G70vVpFzCpn/ff0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iw7qejDnvI09uYvm2Z5n6fRmlaC8Ubrgti1+ldsynfoLvmBtBmROPn4N2QuW72SK1PL5vi6q/pkqzXkiwlwrdCwzbvZVtqmCKNUuyxv9A4qIFAWjg9n9B5AOcTLWEp1P+/xGBosTo5NJdHmqvp8LxjpO/B+nGpeO1p8iJ7W4vM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPkB4SGg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPkB4SGg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqhXGiNES/GeSzECBAFP4Cw9YkFTgSPnFcrP4KJFfFA=;
	b=MPkB4SGgdiDjMKXrx+PsWBux/SPLjsV9LL/e5j3tvJszFI+4pgQJLTBUS9cUXT2iyQUf7p
	xyPxNqyjfMjm2GiGVPTu6QVm6p8cE8BuVtgnPp0yOsSRKOhyw15lY5EtLZ4CjSby7gZfdF
	ZArSw9M9Bm0457/8KCE/4ktKdN6eAxY=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 06/10] rvgen: support reset() on the __init arrow for global-window HA clocks
Date: Tue, 12 May 2026 02:24:52 +0800
Message-Id: <aa156a1c7696e054f8db57c48a26fa6ec1e17395.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

rvgen rejects a state invariant when its env is never reset on any
state-transition edge.  This prevents expressing monitors where a clock
tracks the full monitoring window — reset once at object creation,
active in all states.

Allow reset() annotations on the __init_STATE -> STATE arrow.
automata.py adds listed envs to the new env_init_started set (and to
env_stored so the HA framework allocates per-object storage).  dot2k.py
uses env_init_started for three purposes:

- Generate a handle_monitor_start() skeleton that resets the env and
  arms the timer after the caller sets up DA storage and initial state.

- Guard ha_inv_to_guard calls with !ha_monitor_env_invalid() for these
  envs: a concurrent DA event between da_handle_start_event() and
  ha_reset_env() would otherwise store U64_MAX - BUDGET as the guard
  anchor, silently disabling enforcement.

- Always generate ha_verify_guards() for monitors with invariants,
  providing a stable extension point for future per-event guards.

Models without __init resets (e.g. stall.dot) are unaffected.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/verification/rvgen/rvgen/automata.py |  26 ++++++
 tools/verification/rvgen/rvgen/dot2k.py    | 100 +++++++++++++++++++--
 2 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index b9f8149f7118..178a1a4ffd8a 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -69,15 +69,41 @@ class Automata:
         self.states, self.initial_state, self.final_states = self.__get_state_variables()
         self.env_types = {}
         self.env_stored = set()
+        self.env_init_started = set()
         self.constraint_vars = set()
         self.self_loop_reset_events = set()
         self.events, self.envs = self.__get_event_variables()
+        self.__parse_init_resets()
         self.function, self.constraints = self.__create_matrix()
         self.events_start, self.events_start_run = self.__store_init_events()
         self.env_stored = sorted(self.env_stored)
+        self.env_init_started = sorted(self.env_init_started)
         self.constraint_vars = sorted(self.constraint_vars)
         self.self_loop_reset_events = sorted(self.self_loop_reset_events)
 
+    def __parse_init_resets(self) -> None:
+        """Parse reset() annotations on the __init_STATE -> STATE arrow.
+
+        Adds each listed env to env_stored (HA framework allocates per-object
+        storage) and env_init_started (ha2k generates handle_monitor_start()).
+        """
+        init_prefix = f'"{self.init_marker}'
+        for line in map(str.lstrip, self.__dot_lines):
+            if not line.startswith(init_prefix):
+                continue
+            split_line = line.split()
+            if len(split_line) < 3 or split_line[1] != "->":
+                continue
+            if "label" not in line:
+                continue
+            label = "".join(split_line[split_line.index("label") + 2:-1]).replace('"', '')
+            for part in label.split(";"):
+                reset_m = self.constraint_reset.search(part.strip())
+                if reset_m:
+                    env = reset_m["env"]
+                    self.env_stored.add(env)
+                    self.env_init_started.add(env)
+
     def __get_model_name(self) -> str:
         basename = ntpath.basename(self.__dot_path)
         if not basename.endswith(".dot") and not basename.endswith(".gv"):
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e6f476b903b0..e8066260c0af 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -366,7 +366,18 @@ f"""static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
             conf_g = [e for s, e in conflict_guards if s == state]
             if not conf_i and not conf_g:
                 continue
-            buff.append(f"\t{_else}if (curr_state == {self.states[state]}{self.enum_suffix})")
+
+            state_name = f"{self.states[state]}{self.enum_suffix}"
+            env_full = self.__get_constraint_env(constr)
+            env_bare = env_full[:-len(self.enum_suffix)]
+            if env_bare in self.env_init_started:
+                # env_store is ENV_INVALID_VALUE until handle_monitor_start();
+                # skip ha_inv_to_guard during the init race window.
+                cont = "\t\t " if _else else "\t    "
+                buff.append(f"\t{_else}if (curr_state == {state_name} &&")
+                buff.append(f"{cont}!ha_monitor_env_invalid(ha_mon, {env_full}))")
+            else:
+                buff.append(f"\t{_else}if (curr_state == {state_name})")
 
             buff.append(f"\t\t{self.__start_to_conv(constr)};")
             _else = "else "
@@ -376,16 +387,22 @@ f"""static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
 
     def __fill_verify_guards_func(self) -> list[str]:
         buff = []
-        if not self.guards:
+        # Always generate for monitors with invariants: stable extension
+        # point for future guard conditions.
+        if not self.guards and not self.invariants:
             return []
 
         buff.append(
 f"""static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 \t\t\t\t    enum {self.enum_states_def} curr_state, enum {self.enum_events_def} event,
 \t\t\t\t    enum {self.enum_states_def} next_state, u64 time_ns)
-{{
-\tbool res = true;
-""")
+{{""")
+
+        if not self.guards:
+            buff.append("\treturn true;\n}\n")
+            return buff
+
+        buff.append("\tbool res = true;\n")
 
         _else = ""
         for edge, constr in sorted(self.guards.items()):
@@ -522,7 +539,7 @@ f"""static bool ha_verify_constraint(struct ha_monitor *ha_mon,
             buff.append("\tha_convert_inv_guard(ha_mon, curr_state, event, "
                         "next_state, time_ns);\n")
 
-        if self.guards:
+        if self.guards or self.invariants:
             buff.append("\tif (!ha_verify_guards(ha_mon, curr_state, event, "
                         "next_state, time_ns))\n\t\treturn false;\n")
 
@@ -599,8 +616,77 @@ f"""static bool ha_verify_constraint(struct ha_monitor *ha_mon,
                 buff.append("}\n")
         return buff
 
+    def __fill_init_start_helper(self) -> list[str]:
+        """Generate handle_monitor_start() for envs reset on the __init arrow.
+
+        env_store is invalid inside da_handle_start_event(); this helper must
+        be called after DA storage is allocated and initial state is set.
+        """
+        if not self.env_init_started:
+            return []
+
+        # Collect the ha_start_timer call for each init-started env from the
+        # first state invariant that references it.
+        timer_calls: dict[str, str] = {}
+        for env in self.env_init_started:
+            env_full = f"{env}{self.enum_suffix}"
+            for constr in self.invariants.values():
+                if env_full in constr:
+                    timer_calls[env] = constr
+                    break
+
+        buff = []
+        buff.append(
+"""/*
+ * handle_monitor_start - reset per-object clock(s) and arm the timer.
+ *
+ * env_store is invalid inside da_handle_start_event(); call this helper
+ * after allocating DA storage and setting the initial DA state.
+ *
+ * XXX: replace the placeholders with the actual logic for your monitor.
+ */""")
+
+        if self.monitor_type == "per_obj":
+            buff.append("static int handle_monitor_start(int id, monitor_target t)")
+            buff.append("{")
+            buff.append("\tstruct ha_monitor *ha_mon;")
+            buff.append("\tu64 time_ns = ktime_get_ns();\n")
+            buff.append("\t/* XXX: allocate DA storage, e.g. da_create_or_get(id, t) */")
+            buff.append("\t/* XXX: set initial DA state, e.g. da_handle_start_event(id, t, <event>) */")
+            buff.append("\tha_mon = /* XXX: retrieve ha_monitor for (id, t) */;")
+        elif self.monitor_type == "per_task":
+            buff.append("static int handle_monitor_start(struct task_struct *p)")
+            buff.append("{")
+            buff.append("\tstruct ha_monitor *ha_mon;")
+            buff.append("\tu64 time_ns = ktime_get_ns();\n")
+            buff.append("\t/* XXX: allocate DA storage, e.g. da_create_or_get(p->pid, p) */")
+            buff.append("\t/* XXX: set initial DA state, e.g. da_handle_start_event(p->pid, p, <event>) */")
+            buff.append("\tha_mon = /* XXX: retrieve ha_monitor for p */;")
+        else:
+            buff.append("static int handle_monitor_start(void)")
+            buff.append("{")
+            buff.append("\tstruct ha_monitor *ha_mon;")
+            buff.append("\tu64 time_ns = ktime_get_ns();\n")
+            buff.append("\tha_mon = /* XXX: retrieve global ha_monitor */;")
+
+        buff.append("\tif (!ha_mon)")
+        buff.append("\t\treturn -ENOENT;")
+
+        for env in self.env_init_started:
+            buff.append(f"\tha_reset_env(ha_mon, {env}{self.enum_suffix}, time_ns);")
+            if env in timer_calls:
+                buff.append(f"\t{timer_calls[env]};")
+            else:
+                buff.append(f"\t/* XXX: arm timer for {env} */")
+
+        buff.append("\treturn 0;")
+        buff.append("}\n")
+        return buff
+
     def _fill_hybrid_definitions(self) -> list[str]:
-        return self.__fill_hybrid_get_reset_functions() + self.__fill_constr_func()
+        return (self.__fill_hybrid_get_reset_functions() +
+                self.__fill_init_start_helper() +
+                self.__fill_constr_func())
 
     def _fill_timer_type(self) -> list:
         if self.invariants:
-- 
2.25.1

