Received: from business190-3.web-hosting.com (business190-3.web-hosting.com [66.29.153.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EC3537F8;
	Tue, 13 Oct 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.153.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921097; cv=none; b=Axuwix/JEiP0OiGMmD7fk1tY3Hxg5Vz1zL53HtN89wyEPn3LVNCW74sNZIKemxxsmQLZnEq0BkEAkvfQJwq3rv6KyfhhoFmOwCTyD4uyBVmfg00gGh8JLBTG0C7E95Df3XT6C0XOpNcyDeoZA11yWiNYFps2J01jS4xqh8U/9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921097; c=relaxed/simple;
	bh=aLelHIR5yJLqGPL97R6NBA7YjOJgZjMSuQpuvOQo5T8=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=TK1wNu2M9Gx8kWWVguwPkdaUQ6OljeHn1QczeUuKQ28qUkjSv2+513IXYZMinN9VfPR7Awvx5aVtxVIMc5O8n/tHHWCZRMCOUOJ/GdX89AjElxLcN8u17VLl+w9B89S10+VtmKgCic4+EP81yLpjJakglX1b4Df2/X6y5o5K8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org; spf=pass smtp.mailfrom=mathgraph.org; dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b=S9aUGro/; arc=none smtp.client-ip=66.29.153.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b="S9aUGro/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mathgraph.org; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K2D2Q1jU++LKSVPtHUauGAhtxA7X6OBc+3XScJb8v7k=; b=S9aUGro/uKV5MihxKpuRlxoosO
	TF5H5a6ZjkQUo/etWRHGxeHIcyUoGONcj4meBQOPJ3OqBVIANr5ttzZiIxQo7njuqxELBRDEJnw4O
	r1gjSJFglZpug1NVYOdwjY4u7bTULo5KeaseUuhamV/J1j7XlgAgrTaX02nlu24CdiXF3Wzeahxuk
	hNQFBOoFn7YwYGx/J2bKINA9MFrW3vo1tzsVLjRZjJWsAHzxL9lfycpfSwwKq+KdnzAMAFMVUw0Ce
	JbRVQa98ZQXsvsgWmlDlgslXzXGTpgcNYU0zTNTDeGBznQdBYufa8Ju2c8lK0NfI9c2ZzrKoeRInU
	YovGaRfA==;
Received: from [::1] (port=52792 helo=business190.web-hosting.com)
	by business190.web-hosting.com with esmtpa (Exim 4.100.1)
	(envelope-from <heath@mathgraph.org>)
	id 1xGiX1-0000000C8FX-2P85;
	Tue, 13 Oct 2026 15:51:27 -0400
Received: from cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 via cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 by business190.web-hosting.com
 with HTTP (HTTP/1.1 POST); Tue, 13 Oct 2026 15:51:26 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 15:51:26 -0400
From: heath@mathgraph.org
To: rostedt@goodmis.org, gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] verification/rvgen: reject ambiguous state/event
 transitions
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <11d37dced04f512153c023b8b7361309@mathgraph.org>
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

The rvgen generator builds a transition table indexed by source state
and event. A DOT specification with different destinations for the same
key is currently accepted, and the selected destination depends on the
iteration order of parsed transitions.

Reject duplicate state/event keys after sorting the transitions, before
generating the monitor. This prevents silently selecting an arbitrary
destination without changing valid automata.

OpenAI GPT-6 assisted in finding the issue, developing the fix and 
tests,
and drafting the changelog. I reviewed the changes and take 
responsibility
for this contribution.

Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to 
Lark")
Assisted-by: LLM
Signed-off-by: Heath Sanchez <heath@mathgraph.org>
---
Changes in v2:
- Drop the redundant hybrid-automaton regression fixture and test.
- Match the full traceback prefix in the negative assertion.
- Move detailed qualification results outside the permanent changelog.

Verification: original rvgen suite 30/30; revised suite 31/31;
64 deterministic/hybrid hash-seed replays rejected malformed models.
https://github.com/metalogiclabs/mathgraph/actions/runs/38452477359

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
index 5f25626..8d635fc 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -84,4 +84,9 @@ check "invalid ltl file syntax" \
  	"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t per_task" 1 
\
  	"No terminal matches 'i'" "Traceback (most recent call last)"

+# Reject ambiguous source state/event pairs.
+check "reject conflicting deterministic automaton transitions" \
+	"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot -t 
per_cpu" 1 \
+	"Duplicate transition for event event_2 in state state_a" "Traceback 
(most recent call last)"
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
