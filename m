Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959553D7D74
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210812; cv=none; b=geX4cFgyELe+wPlODX3tYokVzqYxSG+8Q1zbSJlwPwaA9Z0UTcfQv2ltMoNDjRli/i3Yw8kMUeMYxE/ny0cxRSqCg5lvMKNl9MJ46xE80PQaxw6YZr6Q6dl0fekEgeRFfTnq5jkNacA2V+cMcNcDb65Hvm6Faspms81vlJKtLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210812; c=relaxed/simple;
	bh=530USF/iqCNvPl1m1riuFKRkep1/JW4/cuIR5uRDYY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u5jZiprLkdHy4g+I4rMbliTvWfGg4Gguyl4WOMc/EmpXtuOSnHVchIfPFkogrw2PUdKmMzR69wKJ1D2fBv/BiiJGCbiqeuMSID4W75nXSaeVVP/zRpZMGgiH0DyhpiemI4BjtUOMw90V5aWne00dgXlFGt6Rm1pgSnikoqlSESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tep72e1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tep72e1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784210810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmPfV88YQH8LvCKc7zFOxN5ZQDESeB9NWrEQe22OBfQ=;
	b=Tep72e1RHRXScZgSLDTpzfOxCTH6aUei7ICAbsud01zpANk/ciMhaQjaWh4eLAg8veceS7
	MXoMmelLkiQTMkbGf2rd5M5lfICOeGpuFnn7mWukT35rCYwFjS40GATn6XskNmdWvgP4OI
	qaLeIdVG2I/X8QJtKZR7C+I10VtCHvg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Zv8ZE4w0NUeJKADm2jbYrw-1; Thu,
 16 Jul 2026 10:06:49 -0400
X-MC-Unique: Zv8ZE4w0NUeJKADm2jbYrw-1
X-Mimecast-MFC-AGG-ID: Zv8ZE4w0NUeJKADm2jbYrw_1784210808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7266180062D;
	Thu, 16 Jul 2026 14:06:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.82])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6A9181955D88;
	Thu, 16 Jul 2026 14:06:43 +0000 (UTC)
Date: Thu, 16 Jul 2026 11:06:41 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] rtla: Add unit tests for unset in opt callbacks
Message-ID: <aljlX1ZL35k_ul7l@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260629083654.1548925-1-tglozar@redhat.com>
 <20260629083654.1548925-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260629083654.1548925-2-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: bh166ZOpSgmo8U1uy9fNL4wlOzLsW9g5K6CAPa8uL00_1784210808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 10:36:52AM +0200, Tomas Glozar wrote:
> Test for each opt callback that implements the unset option whether the
> option sets the specified default value back correctly.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

