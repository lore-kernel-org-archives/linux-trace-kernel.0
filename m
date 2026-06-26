Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5C30D40F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467012; cv=none; b=XhipYlc+fmxL6tNwOvSz/TtfQ79ogxIHoJR7MTNZqYNp5unqo+otzaVgrdVfiYr8ZLmCDAcxY7DrpLT+/fNQBIhE5tYti4Nayrr6C4/OpF9Qg4eopsSpicrRNok1AV1dsq5bNeNCdFmnVb/y7Vne1dZia6wjPsxIiqHV4Wn2K3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467012; c=relaxed/simple;
	bh=e3Jz6bzrGgsvPdNYBZd1bmHaSP2o6lWN6RuOfpLQ3w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d22SLLMBwU2q5bcmMmVs4yEyqCMiDP+jvYjzSK9orlvoReEwMOlb33iNfeNuBIlEc+15hu4YImSbv0mtuzQxZP/YLx7OeAXbpjBtSuLWoFejofHsU/ONBqcutcXXVT1hrz6HPdMEJWkAmHNCgMBptOjubktgMXwpdYtMZIdsx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2+i2mvH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2+i2mvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782467010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUw4pQtoHlo8dsSFitcZ7VE4SXE623RtWl2ctOayd9s=;
	b=J2+i2mvH1i5HLcKxF3QZD9c9TLa1FylvnDH4rSECxo2VV8jG1Ct4HtkafcDo+d6Rzo+78D
	LdT50OTzA0ve5GZdd2otriTTT8pqzow8rWNR+Fad+CfaPNHhD7AKzao2UY36/3nHqOfeTP
	pX2y5HJCSyx48BmxNEM1ataSHZKg8nQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-rUhmtskUM5u2M0S8Qr4ivQ-1; Fri,
 26 Jun 2026 05:43:26 -0400
X-MC-Unique: rUhmtskUM5u2M0S8Qr4ivQ-1
X-Mimecast-MFC-AGG-ID: rUhmtskUM5u2M0S8Qr4ivQ_1782467005
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81FB11802668;
	Fri, 26 Jun 2026 09:43:24 +0000 (UTC)
Received: from fedora (unknown [10.44.33.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F231118005A4;
	Fri, 26 Jun 2026 09:43:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jun 2026 11:43:25 +0200 (CEST)
Date: Fri, 26 Jun 2026 11:43:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <aj5JuH6AtjDtWIVU@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526205840.173790-6-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: eT8XEwvo6ktVIZv2nt1lXM3g5QheH84jkkgkjxHxX1M_1782467005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/26, Jiri Olsa wrote:
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.

...

> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -266,7 +266,6 @@ static bool is_prefix_bad(struct insn *insn)
>  		attr = inat_get_opcode_attribute(p);
>  		switch (attr) {
>  		case INAT_MAKE_PREFIX(INAT_PFX_ES):
> -		case INAT_MAKE_PREFIX(INAT_PFX_CS):

I know nothing about how x86 CPU works, so let me ask...

What if insn->x86_64 is false? Is it safe to allow the CS prefix in
this case?

Oleg.

