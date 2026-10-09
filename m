Received: from business190-3.web-hosting.com (business190-3.web-hosting.com [66.29.153.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24190395ACD;
	Fri,  9 Oct 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.153.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579567; cv=none; b=kr8S+IU6mQYVp6KCWsAw/6z1yJtHiEGtMHoUaVv8qE8UKIZFLUJj33WbdRUWX1wwH3Dc6XAsalBvQACeHdBcfACMIHInB1d49LMynQVZBqHOPJ7woP17RiaQSFnZyL7oHXuPzxVVOG6YvxM7MyghQ5e0/iS5Fqw7+iJCBkGWma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579567; c=relaxed/simple;
	bh=+LG8rZIo3xGy9o8SVpOSVM2j81iy7dGS9lrvR5gcBpA=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=STGEWkko2ziJHKJb7rBUYZ9DEHFiScssnQyHoeiSupcSeGayMWwcI+nNG1qZUIBMg+1J3rI+jff6oGNPQaxUaJk5vAEL6LM2rjITKqmQwy4zY4E5ey8Bd4wXRLGcTqyxVQ8ypI0DWyBBUhqlHf76iciHWbQMPoKB6xL0kIyFNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org; spf=pass smtp.mailfrom=mathgraph.org; dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b=EMF8grqx; arc=none smtp.client-ip=66.29.153.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b="EMF8grqx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mathgraph.org; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/bdnImn1q/VD1TGOfYGxQOnSm3Di+D93FFe3xs9lFhk=; b=EMF8grqxBl8LxmkzUVe4L8pUtd
	D6Q7Wj+Qeyi/Xl5JqxoFrqdkkG0jMGFnr42XfQBNAM+2EynCJIShM5YVrvfY9TqDdLFHbTd2O3qgu
	+uUXdOqxsMmT2lRyiU6GxE6oJZrKoBBaybHKcu28a4ZgDX6FqOXfiIydQLBpkJvGOa377g2v6iPCg
	NzOrP3IHNysA5uAIyNahXY5rjYy13o5LZ9uDWHJtKp8bf5RL4xOHkQ0IWyYnsqEOvIW9012a/fPWG
	WvbTN/9Coh/LRX3KAQgzmbPEJD2Qz+16R9rUhqIyH17LyL9Vp81UVSB9SXGGc7DesvZn24c9DWAiM
	LFL95K7w==;
Received: from [::1] (port=59632 helo=business190.web-hosting.com)
	by business190.web-hosting.com with esmtpa (Exim 4.100.1)
	(envelope-from <heath@mathgraph.org>)
	id 1xFH1h-0000000D2jo-0c0O;
	Fri, 09 Oct 2026 16:17:08 -0400
Received: from cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 via cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 by mathgraph.org
 with HTTP (HTTP/1.1 POST); Fri, 09 Oct 2026 16:17:08 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 16:17:08 -0400
From: heath@mathgraph.org
To: rostedt@goodmis.org, gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] verification/rvgen: reject ambiguous state/event transitions
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <0201537cbcba3268512d2c3f6a0b51c9@mathgraph.org>
X-Sender: heath@mathgraph.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - business190.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mathgraph.org
X-Get-Message-Sender-Via: business190.web-hosting.com: authenticated_id: heath@mathgraph.org
X-Authenticated-Sender: business190.web-hosting.com: heath@mathgraph.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched

The rvgen generator builds a transition function indexed by source state
and event. If a DOT specification contains different destinations for
one key, the generator silently chooses one. Parsed transitions are
set-derived, so the choice can vary across Python hash seeds for an
unchanged specification.

Reject duplicate (state, event) keys after sorting the parsed 
transitions,
before synthesizing a monitor. This uses constant auxiliary memory and
does not depend on the INVALID_STATE sentinel. Both deterministic and
hybrid monitors require a unique destination for each state/event pair.

Add deterministic and hybrid negative fixtures. On the pinned Linux 
tree,
the original rvgen suite passes 30/30 tests and the patched suite passes
32/32; both malformed specifications are rejected across 64 seeded
processes. Fifteen existing models retain identical transition matrices.

Evidence: 
https://github.com/metalogiclabs/mathgraph/actions/runs/37983741146

OpenAI GPT-6 assisted in identifying the issue, producing and refining
the code and tests, and drafting this submission. I reviewed the patch
and accept responsibility for the contribution.

Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to 
Lark")
Assisted-by: LLM
Signed-off-by: Heath Sanchez <heath@mathgraph.org>
---
diff --git a/tools/verification/rvgen/rvgen/automata.py 
b/tools/verification/rvgen/rvgen/automata.py
index fd37ce3..1f9a56a 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -418,6 +418,13 @@ class Automata:
                  transitions.append(Transition(src, dst, event, reset, 
rule))

          transitions.sort(key=lambda t : (t.src, t.event))
+        previous_key = None
+        for transition in transitions:
+            key = (transition.src, transition.event)
+            if key == previous_key:
+                raise AutomataError(
+                    f"Duplicate transition for event {transition.event} 
in state {transition.src}")
+            previous_key = key
          return transitions

      def __parse_states(self):
diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t 
b/tools/verification/rvgen/tests/rvgen_monitor.t
index 5f25626..6209c00 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -84,4 +84,14 @@ check "invalid ltl file syntax" \
  	"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t per_task" 1 
\
  	"No terminal matches 'i'" "Traceback (most recent call last)"

+# Only one transition per source state/event is representable in 
rvgen's
+# generated table, even if one of the transitions has a hybrid guard.
+check "reject conflicting deterministic automaton transitions" \
+	"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot -t 
per_cpu" 1 \
+	"Duplicate transition for event event_2 in state state_a" "Traceback"
+
+check "reject conflicting guarded hybrid transitions" \
+	"$RVGEN monitor -c ha -s tests/specs/test_nondeterministic_ha.dot -t 
per_task" 1 \
+	"Duplicate transition for event event2 in state S2" "Traceback"
+
  test_end
diff --git 
a/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot 
b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
new file mode 100644
index 0000000..1b63b5d
--- /dev/null
+++ b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
@@ -0,0 +1,16 @@
+digraph state_automaton {
+	{node [shape = circle] "state_b"};
+	{node [shape = plaintext, style=invis, label=""] "__init_state_a"};
+	{node [shape = doublecircle] "state_a"};
+	{node [shape = circle] "state_a"};
+	"__init_state_a" -> "state_a";
+	"state_a" [label = "state_a"];
+	"state_a" -> "state_a" [ label = "event_2" ];
+	"state_a" -> "state_b" [ label = "event_2" ];
+	"state_b" [label = "state_b"];
+	"state_b" -> "state_a" [ label = "event_2" ];
+	{ rank = min ;
+		"__init_state_a";
+		"state_a";
+	}
+}
diff --git 
a/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot 
b/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot
new file mode 100644
index 0000000..d21b91b
--- /dev/null
+++ b/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot
@@ -0,0 +1,27 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "S1"};
+	{node [shape = plaintext, style=invis, label=""] "__init_S0"};
+	{node [shape = doublecircle] "S0"};
+	{node [shape = circle] "S0"};
+	{node [shape = circle] "S2"};
+	{node [shape = circle] "S3"};
+	"__init_S0" -> "S0";
+	"S0" [label = "S0\nclk < bar_ns()", color = green3];
+	"S1" [label = "S1"];
+	"S2" [label = "S2\nclk < BAR_NS()"];
+	"S3" [label = "S3"];
+	"S1" -> "S0" [ label = "event0;reset(clk)" ];
+	"S0" -> "S1" [ label = "event1;reset(clk)" ];
+	"S0" -> "S0" [ label = "event0;reset(clk)" ];
+	"S1" -> "S2" [ label = "event2;env1 == 0;reset(clk)" ];
+	"S2" -> "S3" [ label = "event2" ];
+	"S2" -> "S2" [ label = "event2;clk < foo_ns" ];
+	"S3" -> "S0" [ label = "event0;clk < FOO_NS && env2 == 0" ];
+	"S3" -> "S1" [ label = "event1;clk < 5us && env1 == 1;reset(clk)" ];
+	{ rank = min ;
+		"__init_S0";
+		"S0";
+	}
+}
