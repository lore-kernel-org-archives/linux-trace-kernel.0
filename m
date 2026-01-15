Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FC3D331D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500390; cv=none; b=uku8ueLr7iVViA8IKhPLkYO6mYrpuKq7csExGOjC5MqRQaht+vrIzBt11rllA0/yTMAw+jYnX4sRwP+7BFerzflMHRpItSqyFD6yjeE6fyuPoh3NLhcIVuCi6Bu2CavrRElm0kcEI8IhYjUrRdIZ4WqeV/ULt1zlYgP5hm9xCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500390; c=relaxed/simple;
	bh=qPqVwD+N89+OmXZMVjyMgTwuUQROi1yXruu77aZuTtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6slLq5Qt5+3KYMDrcofYNjC0Hg2MMlaj4v2fZ8AzouDBCIv6DPhg3f48AE+nEQ7zlmr6x4syFEYthM8IpYDnN7J4mFktKAtcQbcvtscwhyfo4/3Bj4BM6JEqnqmiYv7fhMrCXCKsvQAYnm5yvecYqQ+FcRAlvOx5mH0xokhQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8X5f9ZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8X5f9ZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768500387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l5p+BX+C0koUHxT6Sf+Jk/kA4Mq4uveo7bobvP6QJE=;
	b=D8X5f9ZMa9VV+PtVNp46m0axJ3U94p5A5k9hH3x5FlWb8fgwEhAQ604Mf2hovwZgU4Ru2j
	zrFtuu+kBV2yT8Y2RmN3YnM6pxJ9f0FlvdGEp2E/UnukWOLN+ILSRoASOBd1HoMnP8nUbb
	CPuTyo69Sohgqm5W9Nsu6yw757zBwKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-5AwuhdExMwm66ZU6dG7ptQ-1; Thu,
 15 Jan 2026 13:06:24 -0500
X-MC-Unique: 5AwuhdExMwm66ZU6dG7ptQ-1
X-Mimecast-MFC-AGG-ID: 5AwuhdExMwm66ZU6dG7ptQ_1768500383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DFCE1956052;
	Thu, 15 Jan 2026 18:06:23 +0000 (UTC)
Received: from fedora (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E52D51800994;
	Thu, 15 Jan 2026 18:06:19 +0000 (UTC)
Date: Thu, 15 Jan 2026 15:06:17 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/rtla: Generate optstring from long options
Message-ID: <aWksWtNyxUlcVvso@fedora>
References: <20260108095011.2115719-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108095011.2115719-1-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jan 08, 2026 at 11:49:55AM +0200, Costa Shulyupin wrote:
> getopt_long() processes short and long options independently.
> RTLA, like the majority of applications, uses both short and long
> variants for each logical option.
> 
> Since the val member of struct option holds the letter of the short
> variant, the string of short options can be reconstructed from the
> array of long options.
> 
> Add getopt_auto() to generate optstring from an array of long options,
> eliminating the need to maintain separate short option strings.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
...

That's very clever.

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

