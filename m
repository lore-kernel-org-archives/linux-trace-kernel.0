Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78A1F4611
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219172; cv=none; b=RTy0B0ddR7sGLvJ5O/JM6lq218JOZZbQg9bvtHXfXog8qLbMUrwdVo6ImqozH4dRhdfmqZShXDlqJI4KKmsGCGrW3JjluiguohIc055RfsnOgwVZd3+TvJptGy+xN/qxCTM2wYC1Mz4QzX0IbHC3FGRjOFg+b8rU2QWyrsEzs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219172; c=relaxed/simple;
	bh=iyQXswMKHcxe4iBLaFxrHKgfhvPs7okugRaYbFeUnn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JG/AgkZ5EFWruP7yQpwKlrqi5h7Q47S9CNi0yo9qS+JQbfaKPcb3T866C3Rhw2ubZtaqzxGRLxSXGuSa89At9AZA6CdeGDF3bqjgxSvc6KW6UDXLRyJiKIzhkSEpAUCSYSwO3MgYRG86Qq9EjRT1nvioRrtqHZ3F9yx/ewsFDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyPYX6eU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyPYX6eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782219170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/i1Lz4clow5nMwDx36esGQwimuBh1kIKFhTRwfebGs=;
	b=FyPYX6eUKTNO13P+HWUkkEI1cJKeFyOG5IN1Kf7/G6xtCWSerWGYNSxIgHCKXS3NhN/fKE
	WZK4UczWWi4kMARjnLucjH8R/IesQHK4qfMbHUuvB2GVMbcPbNiQb7Hq5wubjV5SLlg4Sz
	NlffwJhOpGM+Efys17Q1Vw0fK49VoCQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-2Wua44gxP9ir3L1QsXf1NA-1; Tue,
 23 Jun 2026 08:52:44 -0400
X-MC-Unique: 2Wua44gxP9ir3L1QsXf1NA-1
X-Mimecast-MFC-AGG-ID: 2Wua44gxP9ir3L1QsXf1NA_1782219159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E45D118005A3;
	Tue, 23 Jun 2026 12:52:38 +0000 (UTC)
Received: from fedora (unknown [10.44.49.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A87D03000B77;
	Tue, 23 Jun 2026 12:52:33 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jun 2026 14:52:38 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:52:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Windsor <dwindsor@gmail.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated
 CALLs
Message-ID: <ajqBkKE8TpQL1mIG@redhat.com>
References: <20260622183109.1137245-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260622183109.1137245-1-dwindsor@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ivEPjIczNlSRSKZGuru-3FA51Sy13-4EZS3d6_zh22I_1782219159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/22, David Windsor wrote:
>
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
>  		long correction = utask->vaddr - utask->xol_vaddr;
>  		regs->ip += correction;
>  	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> +		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
> +
>  		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
> -		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
> +		if (emulate_push_stack(regs, retaddr))
> +			return -ERESTART;
> +		if (shstk_update_last_frame(retaddr))
>  			return -ERESTART;

Well, if shstk_update_last_frame() fails after emulate_push_stack(), we should
probably return another error, so that the caller handle_singlestep() will kill
this task?

Oleg.

