Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804131197C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006875; cv=none; b=G8llB6v/fXEXU4P4p2c4A97wr8OTLP3OkIt/KnSaEBAcmBgYezfS+HbiZYj6YzfB8QAu2EypnUjPljeYoSrVhX/fGWmusZ949PWRNAfQpdHJm2Dj5HCnjTkRYC7dNpxfdi2F+UphFOPaRQEdFFbdf5lEGSRKuyH+RQ8lLDbLjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006875; c=relaxed/simple;
	bh=XUtKPVBH93eDjDd/7F8jTUBig1mbV1QQRlgOWp6viIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eqmgDL/wdq3z8seL1vot8PwKgj/ej888qmaYb1EpdSgvDv/iwu6lmIusLVxX23iRa7JcjUuUh+JTM9r7qrzxEgc7A7FpyHGCBuO58sYXqpbCfWS0ZG1O6TWMrjMAfS7mODhHZwg3o0w4+rkYnML7qMBTyDRXt1GtoLGp3nBnwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eT3oIpPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT3oIpPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZdpT0c5YCeHwU8r9ITPr9wf/HkMMnjH/+VfUKyVGn8=;
	b=eT3oIpPyHbIMt+J9kfKJRb9eZKLbfzrkxTWcIma+D4kP55Nh2+DYdjfl18+lkzzDPey7b6
	dro86o8afnWI4J/6/T+wp9CaGlNly7vQaF/fR54CG47dAJtYr4KSjuxUQqxnpPHwTkGGX7
	fPgju6owMRaUCb20qPvQ04Iv66mO0rY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-MV8E8wDjPbiE7Upunysb_Q-1; Tue,
 09 Jun 2026 08:07:50 -0400
X-MC-Unique: MV8E8wDjPbiE7Upunysb_Q-1
X-Mimecast-MFC-AGG-ID: MV8E8wDjPbiE7Upunysb_Q_1781006869
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D9101955EA3;
	Tue,  9 Jun 2026 12:07:49 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.64.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4EB793008B37;
	Tue,  9 Jun 2026 12:07:46 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:07:44 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtla: Document tests in README
Message-ID: <aigCAMkv1bxu4aJ8@wcosta-defaultstring.rmtbr.csb>
References: <20260514073038.204428-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260514073038.204428-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ipehN5w4LwOW0faYmV9WfLOO5dzRcZYb9Gvk_PhMmtc_1781006869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 09:30:38AM +0200, Tomas Glozar wrote:
> RTLA tests are not documented anywhere. Mention both runtime and unit
> tests in the README, with instructions on how to run them and a list of
> dependencies and required system configuration.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> v2: Add package hints for common distros for Test::Harness (suggested by
> Crystal Wood).
> 
> v1: https://lore.kernel.org/linux-trace-kernel/20260423130759.882247-1-tglozar@redhat.com
> 
>  tools/tracing/rtla/README.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

