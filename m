Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A292BD5B6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635416; cv=none; b=XNBfomKbOWOmZoSnJ3rV99wFDNuFwSAJp7MN6uNMKsQlDlRbfSLiTPueP4lD9PzzIFk7GLFCgTB9FS9eqwYGlvK1IydC45jTJRXMEp6vwmKjJPXZop0QMyxpMZ47XceZPfIx12Szs141OCMsGkPh/6uDVcK8ir7QAycCSykWDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635416; c=relaxed/simple;
	bh=4ndoZIQadw0fx/9dfIwynU9KS2mYw03hR5z3re/dctk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym+cgUDQhZMEJiikEUi8j28OLD+c0cJTm8+4SxABNLvpe3gV32DJHNGKfM/ICFszLUlbScV0sg8p/yp7KPhLdfVUM6skS6sAMzdpfOG5DOcOBBUQtth5AiNXE5cCfcgA2aYwVwZz6CvEa1XFaINnZM6QnxUNJeq4Lhv1ZUb/Z1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KejR72Nb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KejR72Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744635410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMtlMTzc9ePJmlezuKsazNNqLDwaXztNRY4ZPAIEu+4=;
	b=KejR72NbnZCbVmUZT7FlHcz9CTKLMli9CFiQDooI+12ZyROtdiQp8qNoJ+7gOQN/Nsu1v9
	H8boXQX+Ak016pt0Wk74YZs+iyIo0fE4YOKrar1BWDFafAMEEirJcFPAZC0VKeDerf366a
	KQIbiblYFJqURBjtQw1WJnHaCDcNk6E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-HHZHfESfMJSQqcHc6uG-SA-1; Mon,
 14 Apr 2025 08:56:43 -0400
X-MC-Unique: HHZHfESfMJSQqcHc6uG-SA-1
X-Mimecast-MFC-AGG-ID: HHZHfESfMJSQqcHc6uG-SA_1744635401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 861591955DCC;
	Mon, 14 Apr 2025 12:56:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B4CB180B487;
	Mon, 14 Apr 2025 12:56:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 14:56:05 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:55:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv3 perf/core 1/2] uprobes/x86: Add support to emulate nop
 instructions
Message-ID: <20250414125558.GC28345@redhat.com>
References: <20250414083647.1234007-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414083647.1234007-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/14, Jiri Olsa wrote:
>
> @@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>  
> +	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
> +	if (insn->length <= ASM_NOP_MAX &&
> +	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
> +		goto setup;

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

