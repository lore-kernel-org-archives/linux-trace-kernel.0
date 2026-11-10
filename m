Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273615;
	b=nSOevLN6Wxz/EOqiJQ/ODbbImsL9RdZXV6IzEFawoNP+9efxF9xiiNxoflBKKDPVK6Nf
	 XfBF+fYQTvYDkG8eZ9LgZ4m1sZ6469P8FiGSQXkAH2w/w5oLUj3jy6PkSV8vxapP22zfH
	 LOc8/mfJzSBFSnhWDdxWZ+bU/9R3i97JvYMWJm2v1n3xV5TuzX5e5F9ulvTEk3hGJS1SK
	 uy4nRTRZtHA+4pr88VCC8bkLuMwTaz11Q+lxNVyNyhjG2EqnfW4iePoot3m8qwAKPsKrW
	 JbPEByD8e2I6vccehtRawGHOOy/BjdxygdVPTZdK6Pv4xkxOwIroN61jZc4QvIMW8KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/PcTr6Sw+3roSARVn7JHxKN9uIVrbFAPOKmSnUCUhjg=;
	b=AufSTMT3IB8ybBc7bvs+xy/LlyreCRIjTLcaCMjyQdgMjJhnOivmxFpBEgiJ9EgXveHn
	 /AHlRMsJ3ml7ZAuXJbGA/QxILaxEhTEhrxg8p/eMgbGYqpSUTSnq9a5RG1T3VCS0HpZto
	 uMbjSXNc10Va/9aysioo96wpyCvpEzQ0XTojju6I2h8VPY7AtI++8giR5/Eo/l7E1QFot
	 rrq2Mm2ib6+ZLACxDTYP3Wy0NkixudezhRBuLu5iiqLCGUhNywMVLZ8Ij1kim9PGuPOG7
	 D1gFiGkr5+rhymODzq+GFGalYKjnAuVMpToFeQ5jHD5H8RspXuuZJAdT+3DyDPqRDig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbV9h+We;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73766606A338;
	Tue, 10 Nov 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbV9h+We
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FB31F008A2;
	Tue, 10 Nov 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273615;
	bh=/PcTr6Sw+3roSARVn7JHxKN9uIVrbFAPOKmSnUCUhjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbV9h+WeSxnh6sSOMMbu0jK40+SYNeafQwdE0Yp8qdC4XfO9k61jivzZrd8juNkop
	 9ij4Scn7ova0M5OeUM0cV9n/Y0ox+Uic1GtzALgy99N0kV++IlhsiBN6UcGXTkFTIw
	 Qjel2gxrN9mwh9eyQEl3ERIymPudKNPqUjNDOrUHTzhv1QjnqzQGrSzc+cEDv00HWy
	 upDShAIYmKK5fKwb+tCx8leYJb8k1nRyvRKY0ds5IyrPcEHzKxyxqoqhQ7j/dT0v+P
	 t/Izn/HsU8jnGZ1imXxAljSYHrIDkWZ+HvSg6d5K106BZ9gvxZnnOwIMXIAG8Bndly
	 TOM6tKIWTZ2jQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v2 3/4] kprobes: Re-optimize blocked sibling probe when cooling finishes
Date: Tue, 10 Nov 2026 10:20:12 +0900
Message-ID: <179427361240.291326.5904508550839752504.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179427358690.291326.2078291446658598883.stgit@devnote2>
References: <179427358690.291326.2078291446658598883.stgit@devnote2>
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

When an optimized kprobe is disabled (for example, to arm a new kprobe
in its jump-optimized instruction range), its jump is replaced with a
breakpoint (or disarmed) and the probe is placed on the cooling list
until the Tasks RCU grace period completes. While the disabled probe is
still on the cooling list, any sibling probe whose jump range covers
this probe's address cannot be optimized because can_optimize() sees the
not-yet-disarmed probe via get_kprobe().

In optprobe_finalize_generation(), when a disabled probe on cooling_list
finishes cooling and transitions to safely disarmed (list_del_init()),
check whether an optimized sibling probe covers op->kp.addr via
get_optimized_kprobe() and re-queue it for optimization, matching the
freeing_list path in do_free_cleaned_kprobes().

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Drop the unoptimize_kprobe() and reuse_unused_kprobe() hunks which
   were superseded by commits 0be7a931c5e4 and 1ffd6efb1b58 in
   probes/fixes.
 - Drop the kill_optimized_kprobe() cooling deferral since kill_kprobe()
   runs at MODULE_STATE_GOING when no tasks execute the module text.
---
 kernel/kprobes.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c0637302eeae..88601ecc4e48 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -729,10 +729,17 @@ static void optprobe_finalize_generation(struct optprobe_generation *gen)
 			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
 			kick_kprobe_optimizer();
 		} else {
+			struct kprobe *_p;
+
 			/* Still in use; now safely disarmed */
 			list_del_init(&op->list);
-			if (!kprobe_disabled(&op->kp))
+			if (!kprobe_disabled(&op->kp)) {
 				optimize_kprobe(&op->kp);
+			} else {
+				_p = get_optimized_kprobe(op->kp.addr);
+				if (unlikely(_p))
+					optimize_kprobe(_p);
+			}
 		}
 	}
 

