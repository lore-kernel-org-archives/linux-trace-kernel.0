Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C832E8B83
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333939; cv=none; b=gSSGXY2S7K4TQu9FBV3UDUOy6RmfMKaoT8bqBu4C5uBdQ4H7PijBrLxQesKHmCQS4KP1TcOJRReCTcTBTNjBR7u0GzYtj54y91bCwB9VfubnEBYB9Is5tAu1830Mloj300xquuA31g8PkhbV36yGnn2a9IbPOFZuKt4fI4ZF+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333939; c=relaxed/simple;
	bh=5vlDUZUZwiQlLm6jVhrQJ5f0lQQe/0x8ks5t54Vjry0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ertEHQnH0yBy9lEyxvopueyWHEHMllpWUlyGCxdQx5Tt2/xjXto++e6VzyV1SnJi/2EID/FjSW6P5mQ4PrW/x39/h3DMRza1dPzbI9WkbJY0fqFYpwaQPNJ2GNL1xjo9dawRBmqkzmcT3FaYDoMOehj/K0ycYhYxYzHj2lWm0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyOFLpcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyOFLpcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757333937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bW+7NF8VUGFCtj1oVTDPjGSmVH0sAuFf5qtS0rCjfME=;
	b=FyOFLpcGXBsGO1ZZ2QOXKCdVwhsST4i9h5MKo/Th5cBRHOnPvEWVUtCTs9JXLvHDbxhPx5
	bEbbkJehsBudEkBKV38rupuATzC1jNP8j0xreHdhnkpnuAYYIHE88Cn+tkiXFShM+jaNDr
	2em7HDxHH93lsvw6zCl6wS/DbEiol8g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-xpBiZS9LPvSrqiEV8pADGA-1; Mon,
 08 Sep 2025 08:18:53 -0400
X-MC-Unique: xpBiZS9LPvSrqiEV8pADGA-1
X-Mimecast-MFC-AGG-ID: xpBiZS9LPvSrqiEV8pADGA_1757333931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7641F180034D;
	Mon,  8 Sep 2025 12:18:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.189])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B410C180044F;
	Mon,  8 Sep 2025 12:18:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Sep 2025 14:17:27 +0200 (CEST)
Date: Mon, 8 Sep 2025 14:17:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 2/4] uprobe: Do not emulate/sstep original
 instruction when ip is changed
Message-ID: <20250908121721.GB5489@redhat.com>
References: <20250908121310.46824-1-jolsa@kernel.org>
 <20250908121310.46824-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908121310.46824-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/08, Jiri Olsa wrote:
>
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.

...

> @@ -2768,6 +2768,13 @@ static void handle_swbp(struct pt_regs *regs)
>  	/* Try to optimize after first hit. */
>  	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
>
> +	/*
> +	 * If user decided to take execution elsewhere, it makes little sense
> +	 * to execute the original instruction, so let's skip it.
> +	 */
> +	if (instruction_pointer(regs) != bp_vaddr)
> +		goto out;
> +

Acked-by: Oleg Nesterov <oleg@redhat.com>

