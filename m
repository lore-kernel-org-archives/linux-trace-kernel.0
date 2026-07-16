Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB23F54B6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210860; cv=none; b=XIhw75kJlucV917Y4yJ551G7A+K1ajfPoqLYzITvx1FED+WqdPDHDlRU+PxQjpB70WNIcdlanL5ymOxOl0+yJjk2ec7nKoLpJhoV381QYWpfKPbISiq/QkCC9pb3nVc8k2vao+wslKtEue29wvmFao0IFAcThjUHPHMQWnS8flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210860; c=relaxed/simple;
	bh=YUcbSVTL0c1/f0N2UAqyytxWB2JUHObfl9JnYVg/2Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bWBFfujWZmJ3LbPTDeRhjc2jnRYG7nV+vt6CL5t6aNvdic5VBbLuUnuH+0i+OrfU2/N1yUWEge7/rRCYe1xXUGMVKXNKsAZ/nw95vSWrEGiIo7DY1G52GoLUYJ38TgTWdM5X2Z4b6PYQXa5Fsr6//B6ZQ3bYi2q0ZwMrJUumU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBWiJTVY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBWiJTVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784210858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2mw19Fc0oZ3lACdPbpzRVUOBnT9AUCWA8QirOWmNjA=;
	b=jBWiJTVY1ggOU32E5LGVRwIptjih8thsXXjU8gbzTGMO3iTHNmcMM3y97qxER6Kw7DMKOv
	262IOmGOBVDMNvaQumI5E2Ag1EKNgHBdWBcv0RVXYzuG7cYnXhx0ya3wAR/lEvSUVsK9mL
	z75q/ECt9VjP2cbfXGgdJ2DmJAQPB1c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-dc2vbXPYOFquWbUriJfmIw-1; Thu,
 16 Jul 2026 10:07:35 -0400
X-MC-Unique: dc2vbXPYOFquWbUriJfmIw-1
X-Mimecast-MFC-AGG-ID: dc2vbXPYOFquWbUriJfmIw_1784210854
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A2E71954234;
	Thu, 16 Jul 2026 14:07:34 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E35141800361;
	Thu, 16 Jul 2026 14:07:30 +0000 (UTC)
Date: Thu, 16 Jul 2026 11:07:29 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] rtla: Add unit tests for CLI with unset
Message-ID: <aljlk63x785a0tjP@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260629083654.1548925-1-tglozar@redhat.com>
 <20260629083654.1548925-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260629083654.1548925-3-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5RToupHUYJuMSuaGYoczXS1a8-CfuZv8P3qQ3GMPg_U_1784210854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 10:36:53AM +0200, Tomas Glozar wrote:
> Test parsing of command line that sets an option and then unsets it back
> to the default value in all tools.
> 
> Only two CLI tests are added for each tool: short period option (-p ...
> --no-period) and long period option (--period ... --no-period). The
> logic specific for individual options is tested in opt callback tests
> already.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

