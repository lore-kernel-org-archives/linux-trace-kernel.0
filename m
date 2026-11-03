Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750366;
	b=OfgYRLGR2Ccpp7cYwk1nU7h+vNdEKf7szxP731lkP4+3jQCPzUubHutZ7/VjjIzs3lmB
	 R++5scBHryUXPcKmcp12xhnWMc5f9iYlB5dIuZLLwxoB5qm7TuDossTls92jTYC0+ZfQs
	 5/5nHkFr961XhZ7r2JdHlkR/VLiSj2qjDf4ujvpWbsIz1TP7S5HRdnC+WAga1DQjHnxT4
	 BYHLo3SC5ugcrzHbt1UApjdOuyNtLhzMJWKLlOtWDmg9AKmlocteEcV4i4pIPq9YxreEE
	 l816Q9k57z1+TX8veW9XMCRP63cpWbJ4C/MTjpZqcpUR09DmIEPgkLrrFhyErTczV3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=anq0QKvJksdloG0ALwLr8t3bLi61ikHVmrLSFmZApqg=;
	b=0F5G39KAsm50w5uZfwo87zSWZfJgdW1KB8Fw0yQ2bTyyo7mzcxHfvv7DNfS55ps0tPPV
	 E5yBtg90yJRa8DsP6TSeb4UDUP1nDcWZiYLRp8Eap981tRznHln0ZDQqbAq0jVZPjbixm
	 5UtKrdXyj7gYlPq8yZEqPoA0eSYJo1JHr/QCs7qJJB88K//hY3VyejnFWPv4SzhV9nhWD
	 0/BMYrUy5PKttSjKX6EboAw0BI5uGlG2CTySQpVZ1bcBGua1cBCHzqcWLpDpARfilfbHP
	 29X1R1L/zJZaTl+QdDlALrXyOF5DRoNJhhKE1CjOFXFuJhQyqEqg03rCTvcIGsT5eJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEhh6riX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35D606A31B;
	Tue,  3 Nov 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEhh6riX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A855B1F00919;
	Tue,  3 Nov 2026 23:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750366;
	bh=anq0QKvJksdloG0ALwLr8t3bLi61ikHVmrLSFmZApqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CEhh6riXyXnMgDf6zbJbSCdYYLTH+zpB9vrEhEqT6vIV/IQ6z7BMLyKpocnRENySG
	 cw1aN/ogX8RssLvpGrKTwRmK3vPgKeVRJO8HfWEUGPBCRkjgC+qldteH9zoB3Tm8pV
	 sG+AHgTN2XBBVSjn5K46uc++04YKOpTDt57muKb85+kYwq1HBXWJiD1eAPF3c1OPNz
	 TPec0FzFkHG6/0u9rUwHW4eO8PcalcL5x+sga4f0UhsXrt6VkxmpzRgGDbia/PKtwB
	 +On5+ZcUe66r0sZy0AvjWWKI7bAeskfGBPwcCTZltUYJ6jkuR7aUNrLvz3LTSxuT/D
	 02GVpNJ+A+VRg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 7/8] kprobes: Fix slot reclaim and sibling re-opt in optprobe state machine
Date: Wed,  4 Nov 2026 08:59:22 +0900
Message-ID: <179375036234.247640.2681461872008285645.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Several edge cases in the optprobe state machine can prematurely release
instruction slots or stall blocked sibling probes:

1. In kill_optimized_kprobe(), when a probed module is unloaded while child
probes still exist on p->list, the probe is not unused (!kprobe_unused(p)).
If op was queued for unoptimization, move it to the cooling list rather
than immediately calling arch_remove_optimized_kprobe(), ensuring Tasks
RCU elapses before slot reclamation. In optprobe_finalize_generation(),
reclaim the optinsn slot once cooling finishes for kprobe_gone() probes.

2. In optprobe_finalize_generation(), when a disabled cooling probe
finishes cooling and transitions to safely disarmed, re-optimize any
blocked sibling probe at the same address.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0ef3a8701eda..53725c09ef9b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -725,10 +725,19 @@ static void optprobe_finalize_generation(struct optprobe_generation *gen)
 			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
 			kick_kprobe_optimizer();
 		} else {
+			struct kprobe *_p;
+
 			/* Still in use; now safely disarmed */
 			list_del_init(&op->list);
-			if (!kprobe_disabled(&op->kp))
+			if (kprobe_gone(&op->kp)) {
+				arch_remove_optimized_kprobe(op);
+			} else if (!kprobe_disabled(&op->kp)) {
 				optimize_kprobe(&op->kp);
+			} else {
+				_p = get_optimized_kprobe(op->kp.addr);
+				if (unlikely(_p))
+					optimize_kprobe(_p);
+			}
 		}
 	}
 
@@ -1084,13 +1093,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
 				list_del_init(&op->list);
 			}
 		} else {
-			list_del_init(&op->list);
+			if (optprobe_queued_unopt(op)) {
+				/* Move to cooling list so optinsn slot is cooled down */
+				list_move(&op->list,
+					  &optprobe_gens[optprobe_cur_gen].cooling_list);
+				kick_kprobe_optimizer();
+			} else if (!optprobe_queued_cooling(op) && !optprobe_queued_freeing(op)) {
+				list_del_init(&op->list);
+			}
 		}
 	}
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 
 	/*
-	 * Don't remove the slot if it is queued for freeing or unoptimization;
+	 * Don't remove the slot if it is queued for freeing, unoptimization, or cooling;
 	 * the optimizer will reclaim it after the quiescence period.
 	 */
 	if (!optprobe_queued_freeing(op) && !optprobe_queued_unopt(op) &&

