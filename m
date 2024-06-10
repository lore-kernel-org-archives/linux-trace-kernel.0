Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD906F303;
	Mon, 10 Jun 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054817; cv=none; b=MQu7KQ9MDsarjTxK0pCQD51EJ7C5EP0vSCgPofEqyGfOoU0dgTiUfR7ES/3grE/aRy56ePvcGlaeGh5DgcKhcxAuncIfMHl6nPIoj4Te340fRQuqlDmF+YPVdAHoyBv8J5wuFjpxDFC7tufWhiW/aA1WBEBADAwRZKkig/P2Qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054817; c=relaxed/simple;
	bh=RiDiiRL4D9ZYJMcdrUXWd2Q9FPZ3gwM3t30z+w+Axb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoJAp9EIfN5UCZlMsVcD6OR0DrqlEXtR0dbFBfPpoIJLR4trraJhoH6UVI+61GubVpP451X+/9Wljp/x5x5DLJgRIVBdJjtep5kC3oNaoBge3RwMrAlqVKTgRIhUNDs1VcZFz7WiIFlG+OUR5ymv4r0uElU0km8FoEecmcmztx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZZGcinO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZZGcinO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8EBC2BBFC;
	Mon, 10 Jun 2024 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718054817;
	bh=RiDiiRL4D9ZYJMcdrUXWd2Q9FPZ3gwM3t30z+w+Axb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZZGcinOBeX/yub55aZO3L1pdptNHFAtcBw12B5aDJvjHIvNE9Y1LLJswmEuI2fan
	 haS6N5HtCUVs/OB1NrqHeRuEBN9BMm8wKuVNil1c6Won67BlKrde2eng41RiVMLjSy
	 7H5CCUN2wdsW++d7RVgxN2wKrPb/t70lGKMhQ8HesGP82aaWs9pvc3o9C9oLLUHoJV
	 jACjU3mc6GV7i75iLIf1FRF68764rywrQGfRYi/ui6NOPLvWqGJhsx+/KB+Eb0QE01
	 S9juSyKB2K8CCFBlU+THeJTIy32TWvu4MM4r94r2UJcMaIGQYDnvFOz72XpjOohipG
	 b7CYPCoAxBtyw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/3] tracing/kprobe: Remove cleanup code unrelated to selftest
Date: Tue, 11 Jun 2024 06:26:53 +0900
Message-Id: <171805481328.52471.14726358281044398289.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171805478534.52471.6269290579314514778.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This cleanup all kprobe events code is not related to the selftest
itself, and it can fail by the reason unrelated to this test.
If the test is successful, the generated events are cleaned up.
And if not, we cannot guarantee that the kprobe events will work
correctly. So, anyway, there is no need to clean it up.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4abed36544d0..f94628c15c14 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2129,11 +2129,6 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 end:
-	ret = dyn_events_release_all(&trace_kprobe_ops);
-	if (ret) {
-		pr_warn("error on cleaning up probes.\n");
-		warn++;
-	}
 	/*
 	 * Wait for the optimizer work to finish. Otherwise it might fiddle
 	 * with probes in already freed __init text.

