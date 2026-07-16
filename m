Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D830D3F6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210784; cv=none; b=Ue4OMH85a8M40HKCbLGnztKQ2kCdZvh1Jxi4x5oVX0ZkTtzMyaS0RQX4Iih/vJc9zbJBJm1nKWQhmI5sinHR3tpA6c24SHxM/68Pkh+bmSHZLhpis/R4dzITAt5QyybeYZSrBQqTY54VfiEqAFsxkGe7HDbXGwKmgVLjznitOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210784; c=relaxed/simple;
	bh=op55ElCpnl/jHk0U6kcIBC6aY/AAk9or9SdxOeZpUT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Eg8XG44ilkh2OLrM3ew2s2Cmez9kDZIu1aKS9GuPvaA4QZjmFU/3UgAiaVCII3PRdqhTNVKPpH+HsmxZLR0inTBOkeakCDtMHD5Bu8IpAjikObWkF5jupFe6COZUWJG+SN+yONFfL8WF5oN+o6vRJeyzK+tiyZe0dP/tH/2oigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET4uxcD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET4uxcD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784210781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QgqpuFmKbRUakHwhP055iAv5AsCZtpbG6MOV8q78teM=;
	b=ET4uxcD9EacF3cfKLejMEHf7ueSYf9coWpHJN7ngQapc8TqXh1cxVw6LS2TkHVamODCV1v
	gt4Uvuyxf+z9B0fJZMqN8wWbKQfu/vbY9Yshdta7gWswvyRaBaGYlu4mO6A9WK07REoqG3
	+w8GaZThrPFgeBKqBnWdtP/2ZwjPc5U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-tbbhQ1Z6O5GoBGMttPz5Pw-1; Thu,
 16 Jul 2026 10:06:18 -0400
X-MC-Unique: tbbhQ1Z6O5GoBGMttPz5Pw-1
X-Mimecast-MFC-AGG-ID: tbbhQ1Z6O5GoBGMttPz5Pw_1784210777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DAE51955EA1;
	Thu, 16 Jul 2026 14:06:17 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.82])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 468781955F78;
	Thu, 16 Jul 2026 14:06:12 +0000 (UTC)
Date: Thu, 16 Jul 2026 11:06:11 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] rtla: Allow unsetting non-list custom-callback CLI
 options
Message-ID: <aljlN9MfcxCgzrVW@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260629083654.1548925-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260629083654.1548925-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: dDxsKh-TABhb76UYAT7Qd6io4tFq8XeBGov7Rnsgtx0_1784210777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 10:36:51AM +0200, Tomas Glozar wrote:
> libsubcmd implicitly allows the user to unset already set options using
> a "no-" prefix for long options. For example, if I set the period like
> this:
> 
> $ rtla timerlat -D
> Loading BPF program
> reading osnoise/timerlat_period_us returned 1000
> setting osnoise/timerlat_period_us to 1000
> reading osnoise/print_stack returned 0
> setting osnoise/print_stack to 0
> ...
> <timerlat top>
> 
> it can be unset by a subsequent --no-debug:
> 
> $ rtla timerlat -D --no-debug
> ...
> <timerlat top>
> 
> Currently, this works only for boolean options. Extend the feature for
> all options by implementing handling of the "unset" argument in opt_*()
> callbacks defined in cli_p.h, except for list options, i.e. options that
> can be passed multiple times (--event, --filter, --trigger,
> --on-threshold, --on-end).
> 
> This allows, for example, unsetting of int/long long options, e.g. "-p":
> 
> $ rtla timerlat -D -p100 --no-period
> ...
> setting osnoise/timerlat_period_us to 1000
> ...
> 
> By default, options in params struct are reset to zero. A constant is
> added for every parameter with a different default value, which is then
> used both in <tool>_hist_args() while setting the initial value and in
> opt_*() when unsetting the option. This refactoring ensures there is no
> duplicate "magic number".
> 
> The default value for opt_llong_callback() and opt_int_callback() is
> passed in struct option's defval field; new macros
> RTLA_OPT_{LLONG,INT}{,_DEFVAL} are added to define the field
> conveniently. The default value for other callbacks is hardcoded inside
> each callback's unset logic.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

