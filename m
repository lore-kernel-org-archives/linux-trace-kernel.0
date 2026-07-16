Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71342385521
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218868; cv=none; b=FudrUuxLDPXExzJNSoowNAee18TvulVhmRWl5+vwF72Kacr+lTrAno1Ng1doln3LdCh4lUDvJwQOgTdvhTt/v/IZVa11Es9ieQ4BQs6fQngZaRn9zDWgItIiaY57/f2bhBt+stEFl7JJ1gYwUn96a8ndc2+AISE6F6O4goWh7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218868; c=relaxed/simple;
	bh=UYKHgbyDQegeDSaK2kOd56lSAaGS/ISitH6WR6gKbWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j1h489w3fFXcZGMPyDeP9QmRLqBWuO4dcVNAiiegwXhHVm5jwNTGEY5KCH9ZRy3GRomDNh3a4Xc9IoZKfiT812j0DJMRFizODneNTe29uXKD/rre9YQDor9GIaa1JPwhhIuYE+fdbQZDbJweyueZ0FgAdWQjXPtRzdH0MQx6xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGBZ+e5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGBZ+e5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784218863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxhT/CuT7EJFFFdtExnTMTEUNBnCZfCemkSGOTEWC+o=;
	b=NGBZ+e5E5unUnSgUgmD7cQNTonQ3doBhXD+8IUPGY1TtEd0el4agCNbhZzRQ6bg0IcT13b
	04sj8j71gBF5XbMgelzdpz86BPk1zbglIAN3RsmSSyCSPhETFyI8OZJCpRBOuPPJAW2sVy
	3fvjiDq7NeY9BY5GRsNbu3jAXXhbRE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-3FwtfG9POqqK_faFZm3jIw-1; Thu,
 16 Jul 2026 12:20:59 -0400
X-MC-Unique: 3FwtfG9POqqK_faFZm3jIw-1
X-Mimecast-MFC-AGG-ID: 3FwtfG9POqqK_faFZm3jIw_1784218858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DF431954B3B;
	Thu, 16 Jul 2026 16:20:58 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.80.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0ED981955F7F;
	Thu, 16 Jul 2026 16:20:54 +0000 (UTC)
Date: Thu, 16 Jul 2026 13:20:53 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtla/cli: Unify and improve handling of invalid option
 arguments
Message-ID: <alkE1Ga091Qar4DS@wcosta-defaultstring.rmtbr.csb>
References: <20260716144901.1187474-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260716144901.1187474-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Z5Pec0R6Ra9f7exKZigizho7qbM3IQ15Mcmvc4XGweE_1784218858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 04:49:01PM +0200, Tomas Glozar wrote:
> The current handling of invalid command line option arguments is
> inconsistent:
> 
> - opt_llong_callback() treats non-numerical input the same as "-1",
>   which might or might not be rejected later.
> - opt_int_callback() returns -1 on non-numerical input without an error
>   message, which makes parsing fail silently (libsubcmd will
>   automatically print the usage of the option only, no error message).
> - custom callbacks abort command line parsing using fatal(), which
>   displays an error message and exits, without libsubcmd printing the
>   usage.
> 
> Unify this such that all invalid options, regardless of the format,
> print an error message similar to the out of range case:
> 
> Error: --opt: 'value' is not a valid XY
> 
> followed by the usage of the option, e.g.:
> 
> $ rtla timerlat hist --period=1us
>  Error: --period: '1us' is not a valid number
> 
>  Usage: rtla timerlat hist [<options>] [-h|--help]
> 
>     -p, --period <us>     timerlat period in us
> 
> As this is a libsubcmd help path, all option parsing failures now return
> the exit code of 129 (help).
> 
> The unified handling is implemented using a new error message helper,
> opt_err(), which is called from two new CLI-specific parsing functions,
> strtoll_safe() and strtoi_safe(), as well as from custom helpers.
> 
> Option callback tests are updated to cover the new behavior.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

