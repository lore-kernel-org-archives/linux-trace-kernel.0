Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93B65C;
	Wed,  4 Sep 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411145; cv=none; b=NNg4BL/FuuKYN5S+aUVN0HronVRLBnCt5ZPfr1WMvVQMjp4ocPBmIBoF+9NTeVxzBIYIiAXe/42pLcAte8bwZRvpZOUTf9Yft45EYrlUb50cBjeLD+zrcXDgzFdSIiEaeCi8rNSQf6zyW37hCCKq6AkHVoL0dB0qyOb602JBG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411145; c=relaxed/simple;
	bh=G21Eq5cw+VZfTA9iPHaQQM23pVQaJEAh22KOsqmNfu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8d63sbmclTj2tJHBZvCqd4fimTY1nJMl2peScb8nG0+0XJzmqchht6q8G4ba8BcsZCl8ScRYhtQhoJzFbvYeoMwOrqSsNQ1Ct3GLWiMz/NJSt7CDJefiZCSR1zZ9lg+6gF06/6TTONKbU+cNwBduArh+mNgaYiPPQzGvcidz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA16AC4CEC4;
	Wed,  4 Sep 2024 00:52:23 +0000 (UTC)
Date: Tue, 3 Sep 2024 20:53:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240903205322.69d7638c@gandalf.local.home>
In-Reply-To: <d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev>
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
	<20240829041912.GB4408@lst.de>
	<4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
	<20240903072512.GA1521@lst.de>
	<20240903092154.5f0bfafe@gandalf.local.home>
	<d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 10:36:29 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> This doesn't apply for arrays:
> 
> 	field:__data_loc u64[] addrs;	offset:12;	size:4;	signed:0;
> 
> Here the size is not for the data type but for the array. And so the
> type is parsed by process_sizeof in src/event-parse.c.

Ah, I see what you are talking about:

+	TP_printk("%s dir=%s phys_addrs=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(addrs),
+			      __get_dynamic_array_len(addrs) /
+				sizeof(unsigned long long), sizeof(unsigned long long)),
+		decode_dma_attrs(__entry->attrs))

That part.

Yeah, the "sizeof()" parsing is somewhat of a hack. It would be trivial to
add u64 and all the variants to that.

This should do. I could get it into the next minor version.

diff --git a/src/event-parse.c b/src/event-parse.c
index ddeb3b9909c0..73563c8e9dea 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -3571,6 +3571,23 @@ process_sizeof(struct tep_event *event, struct tep_print_arg *arg, char **tok)
 			/* The token is the next token */
 			token_has_paren = true;
 		}
+
+	} else if (strcmp(token, "__u64") == 0 || strcmp(token, "u64") == 0 ||
+		   strcmp(token, "__s64") == 0 || strcmp(token, "s64") == 0) {
+		arg->atom.atom = strdup("8");
+
+	} else if (strcmp(token, "__u32") == 0 || strcmp(token, "u32") == 0 ||
+		   strcmp(token, "__s32") == 0 || strcmp(token, "s32") == 0) {
+		arg->atom.atom = strdup("4");
+
+	} else if (strcmp(token, "__u16") == 0 || strcmp(token, "u16") == 0 ||
+		   strcmp(token, "__s16") == 0 || strcmp(token, "s16") == 0) {
+		arg->atom.atom = strdup("2");
+
+	} else if (strcmp(token, "__u8") == 0 || strcmp(token, "u8") == 0 ||
+		   strcmp(token, "__s8") == 0 || strcmp(token, "s8") == 0) {
+		arg->atom.atom = strdup("1");
+
 	} else if (strcmp(token, "REC") == 0) {
 
 		free_token(token);


-- Steve
