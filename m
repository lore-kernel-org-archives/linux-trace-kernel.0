Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960949;
	b=kSLOag74UQTj5Krs2kn5VmYUN6DSagbhIgDRRD8USMQQaPDkGtg/1Tte2Z2Fqqjo9ZjB
	 IVxcXiqrNceFIKiGJCQXlfUCl7nJtoHnFzidQZgcBjz90i1OWNujx2XuWZgl1VlyvNOvx
	 6JuE7ZuTx0XkifVMI+Zo23R1lvKJAOKqi66lwS93ZMKBlLhEatuRUbS04HDF3nnxFIu4d
	 R5CHMu1E/yZxHegUOzjpag8woIyWpjcwxSWbRBWvQfut83WQUtmRytFfQSbaITc5Rx1Sb
	 yU/wIrdw6GvSPDZ5wDm1r6JpT0qeTGr9cs2wWnLlEPakmpbXdmvLk7Q08EYFA+WxUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960949;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=oHcgMX1+EqI/uihoJLo/bWzXSeSl9Ms6q92fgtHYDzE=;
	b=LWGdXHroCP3ttPi1H6RWjcWKhKbAIIPlE0hHj0nLgyr21D3BX3t5gT7+tl5Q4KZ/kcpL
	 MtnX/6/rC0npq/yffhM32Smp/0u/ENwi9g1s0Xhcz5jQsTL76FX2as3MIJYt9Rl+CBX0t
	 NX7kCi9kIKArX/JiGlMV+T8n4f42Ma2RxoVMlCQGVFOV2afsttMKEDr1TU3h33/RFEDhS
	 jorOvQM7hV9Qu8MldgY/4VQpsjpsjaq+dFK5YI+OTMzp4FVBpxN3uJ88C5umVAykZVidI
	 W/nFPciL2VhYbOKyGWytL1wfV4mJxvDipD5yfIou5/O1KkVwEGSTltZpQUAywBB5xLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jItK7ylW;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60148606A31C;
	Wed, 18 Nov 2026 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60148606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jItK7ylW
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D123E1A05FA;
	Wed, 18 Nov 2026 00:15:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E56B260016;
	Wed, 18 Nov 2026 00:15:45 +0000 (UTC)
Date: Tue, 17 Nov 2026 19:15:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 07/15] tracing/filters: Reject empty unquoted operand
 in function event filter
Message-ID: <20261117191544.7b60ce1d@gandalf.local.home>
In-Reply-To: <179323791027.740114.822862076687011726.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323791027.740114.822862076687011726.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h6x5fjqxtgn8q8e7h55ts4xx7mgi5uyj
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E56B260016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+veiXigOPMW8los+kp/zDgO8Td6v4eOiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=oHcgMX1+EqI/uihoJLo/bWzXSeSl9Ms6q92fgtHYDzE=; b=jItK7ylWTpZ26SX1l1f9IY+58Kdhtagnj0XIYGu6olDp//GB9M/ZcK7obWU9fqR/bqoFQ1akBSAhmaF3HR3ueDPBXZNjs0YXy3Y6XZ9mU+oGqih0lnio89uyl+UQS02diM4Z+sWlCh6cFfy7THNZzDpUGVg875rKUoMva03Ri/M=
X-HE-Tag: 1794960945-194128
X-HE-Meta: U2FsdGVkX1+mxosj1zZaGVOSJiOAmE4kBN7u7K1bAdgtebFwdEZIqlRBBXAb07UuI+IaipZkTiHHFm7Mbe19wG7Es83IzfxV9Hgun2rsKNIQd25An3mndCG7jAhG/qG+L2G0Kq0hru7EtIt8yMvlEVCGY2uqla2q/iPF0IGczMQ/8GboimHUt8y4uZJHrLJ5pwOSDhF0At47GQVxtNpocT1zbOsAI8XgcscouBo6CkkOsZn3gBlbsxgJVkSCR0nJfoKwEOF7PZuHcR7/SyUDlhVYe91peo9ecIL3nMmb/l5sgHGtogix7pdqnYf7LgduWN+jI/c0EOPtb3XhVRDmH5Kzoj5e86mC

On Thu, 29 Oct 2026 10:38:30 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> In parse_pred(), when parsing an unquoted operand for function events,
> if the filter expression has no operand before a delimiter (e.g.
> '(ip == )' or '(ip == && x == 1)'), the loop terminates with len == 0.

Please show actual examples for this too. Not just showing "this breaks",
but the actual echo commands that are written to the tracefs file system
and how they fail, or not fail.

Thanks,

-- Steve


> 
> While an empty quoted string (e.g. 'ip == ""') is syntactically valid
> and denotes an empty pattern, an unquoted empty operand is a syntax
> error where an operand was expected before the delimiter. Previously,
> this accepted the predicate with an empty pattern.
> 
> Reject empty unquoted operands by checking '!q && !len' and reporting
> FILT_ERR_INVALID_VALUE.
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
