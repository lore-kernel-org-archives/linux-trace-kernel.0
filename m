Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3B3B0AC7;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071852; cv=none; b=DZkEuEv8EGFB3GFtxuBgb+TNQGGI8vh2RNK6YtwesYSYf/+z+7QdyTg9crP0V3fWWRm2q4RC1zZKkJ3SQxiDbg+9SO+qmiudpnBeZS+Y16VwcUbeqljXoLQJNLACa8z1XRe6KQvFqG3uDwyyN7iCy5il5s9s9648tlS92WhjrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071852; c=relaxed/simple;
	bh=tbKdHUzW7Ney0ZAz7INWz59q7BVoFALOrdmymC9RXiU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MG+SuQHXldgP2zU4voPk9Vv1QIHwWxtjPlmNZ0+eXs3gzsuIdLxlyhjrriFqwUZINDh2Os+Wl6OpJtkVY/9U2AU/AXHWJem7vjgcGMnbbPT6VNjjttxZrTNS6JFU5VcmzS/Y8VcluffQew68noiegNmKGfIy8GCACxPvU0RktsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdZ/xATc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdZ/xATc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485821F00899;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071849;
	bh=Orisqu9iXlB28JI6meJ4MsrFoMA5BiMmrwEBEPyaxHU=;
	h=Date:From:To:Cc:Subject:References;
	b=JdZ/xATcYObJDf5HGexkVDQPEwJ/GBuNq7XONUAz0pXgvSKGuFhCJt9v4lx4cdhKm
	 qLX3QK1EW+gsudBRH1fpp+W33Lc/sWq7akTSJBmcCf0op5sIbW/UEMyAUtylPTuUCi
	 Fs48+Z/UfMdiLfbc3D7h8HgTuer/+AdmZYzf6qejwP79tIVzrkkZS+TEBbLwhQhdsY
	 RGeBM5VHNc+tfhN0FFm3FuMYcYaSNELZTzzvDu7W8yuQghdDYLDvASviY+7wqfvwBm
	 oXP8vkqkrFfmr7r+n+ZWZ+XzwboZttYjIGdTt2PvTJ2cAj+7qgY23hG++m9RTlN22B
	 cji8WUZJBGHyQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x4lKq-00000008eZq-3Zep;
	Thu, 10 Sep 2026 16:25:28 -0400
Message-ID: <20260910202528.700804592@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 10 Sep 2026 16:24:23 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] tracing: Invert the logic in mmio_read() to get rid of the goto
References: <20260910202421.612273038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Simplify the logic by removing the goto in the first condition and
inverting the logic of the early return.

This changes the reading logic slightly. Before, the goto would exit the
function right away with the output of missed events. The next read would
then update print the saved hiter->dev and update it.

Now, in one iteration, if count_overruns() retruns !0, the lost events is
printed as well as the next hiter->dev without needing a second loop.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260721212010.76e9ed61@gandalf.local.home

- Broke it up into two patches

 kernel/trace/trace_mmiotrace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 0034d6af3d9d..c49738cdb439 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -143,16 +143,13 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		if (!overrun_detected)
 			pr_warn("mmiotrace has lost events\n");
 		overrun_detected = true;
-		goto print_out;
 	}
 
-	if (!hiter || !hiter->dev)
-		return 0;
-
-	mmio_print_pcidev(s, hiter->dev);
-	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
+	if (hiter && hiter->dev) {
+		mmio_print_pcidev(s, hiter->dev);
+		hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
+	}
 
-print_out:
 	ret = trace_seq_to_user(s, ubuf, cnt);
 	return (ret == -EBUSY) ? 0 : ret;
 }
-- 
2.53.0


