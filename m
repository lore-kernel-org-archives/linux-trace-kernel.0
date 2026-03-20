Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B13CBE6B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Mar 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027926; cv=none; b=hCZgK4y65vdMdmiv4dB1Ay57+4PcWb4NFRokfFPDZSVh+71JJwUKHiBtd1VaNonlBwVlWZtEBXpjRvul1HtPvsuiJQxotu0ErKNyxBDhl7uMxV6uMJP8EjFaE0o92vjJJNv0IStle6bumsT3+szUeuanvySk4/YMRtPn+94qFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027926; c=relaxed/simple;
	bh=E6aRQ367u5hgWjKYG0nqKkdIuMauzwGRTL3rsHqFQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LEvJQn0eUk86b9OCc1oSNXQ9EhaMVjXAqgsLkFyW0KLj4HsiERNU05PTCmHf2F80WlJKXLAyy7si7EC9ptT6CU2KlupjEjD32PS5flJO+FH/C/h2TSm/nFArKxuY/84GIB5n1uf8ceHBruBRzUtumD2oqf377+fvb2fXJRvFqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7ig9kcy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7ig9kcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774027923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpmkD8/1OErEP+Wqm/7F8P6jM8zuQtHg7khB2iRLIYo=;
	b=d7ig9kcyy4hC9cBivtYak97dAOEzXoKJZtqZl2iEHQ4Kmaz9yT3d23/LdnX5bTqCXvbm6N
	U13QLTs9zAtoNsNfPdEbueaPWUg8yXhQdfamp4x9wYIC1At2It4XPYiuUecMp2mLTR4QqT
	eu1Udu6Os4CqEVgca7LSpTlKNhtCx4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-rhYYQ86JNMONuO5uU-EJVw-1; Fri,
 20 Mar 2026 13:32:00 -0400
X-MC-Unique: rhYYQ86JNMONuO5uU-EJVw-1
X-Mimecast-MFC-AGG-ID: rhYYQ86JNMONuO5uU-EJVw_1774027919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50A7C18005B2;
	Fri, 20 Mar 2026 17:31:59 +0000 (UTC)
Received: from 192.168.0.121 (unknown [10.22.80.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 378C81800361;
	Fri, 20 Mar 2026 17:31:53 +0000 (UTC)
Date: Fri, 20 Mar 2026 14:31:52 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
Message-ID: <ab2D0a32yuwYTO1K@192.168.0.121>
References: <20260320150651.51057-1-tglozar@redhat.com>
 <20260320150651.51057-4-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260320150651.51057-4-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: yFst8fVAeDoSlmAzRgXvD4yFkjd1RQ8CqEx6BZmhQxY_1774027919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2026 at 04:06:51PM +0100, Tomas Glozar wrote:
> Instead of using getopt_long() directly to parse the command line
> arguments given to an RTLA tool, use libsubcmd's parse_options().
> 
> Utilizing libsubcmd for parsing command line arguments has several
> benefits:
> 
> - A help message is automatically generated by libsubcmd from the
>   specification, removing the need of writing it by hand.
> - Options are sorted into groups based on which part of tracing (CPU,
>   thread, auto-analysis, tuning, histogram) they relate to.
> - Common parsing patterns for numerical and boolean values now share
>   code, with the target variable being stored in the option array.
> 
> To avoid duplication of the option parsing logic, RTLA-specific
> macros defining struct option values are created:
> 
> - RTLA_OPT_* for options common to all tools
> - OSNOISE_OPT_* and TIMERLAT_OPT_* for options specific to

[snip]

> -int getopt_auto(int argc, char **argv, const struct option *long_opts);
>  int common_parse_options(int argc, char **argv, struct common_params *common);


The function common_parse_options() body was removed, but the declaration remains.

>  int common_apply_config(struct osnoise_tool *tool, struct common_params *params);

[snip]

