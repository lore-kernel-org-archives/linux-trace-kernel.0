Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBD3CF209;
	Wed,  5 Aug 2026 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955236; cv=none; b=V6/gM5t8kJApkqizHrAkGNKZWgTRbGm5cyRfWPTd2Ce6QNGtB9yRc99Orts1sV4LEdxTnZvbTXZ/HWP7feFCpw1fgZ35+/J0cMpTRiGwVXS79g1WAWbCltE4zN9iyNVwSeJQlfiOxcbm+KWbiW/EVV+0+eWch8F63WepUgQShcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955236; c=relaxed/simple;
	bh=98BO7RMpR2xrrww86mmgX6RJ8Olcp7BRbc3ihodrtVc=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=kvTvMqN9lZKoEWL3RmIxZJUFAkx2jCNAdtm2VuvUB90VAL4ewTcWA4LmFvTDlliPaPNMH7zMqsKCcyKNPuizlml9sdp7BEAr2oc2Ps17G6lDKE1xZWFdxeGC9QEWzk5q+XctRWFkbjXON7AUSCwYzjUwAyuzFdac18Ttyk3CglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=MgjDjZNC; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="MgjDjZNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785955225;
	bh=rwpUlh4NHPnts4FjOuLmwbsu7qvnIU7QdypuEF7AYzw=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=MgjDjZNCnY8FR2wPjuxm3gfQUtgo4wOGKCizTWxambglDg84pxLK2WmqU1Nmdfw8R
	 lCm2KPmEoLpV/XGjl6px3MUpOk2kIH2E0wuRcKeFluWNlb2UC/mj2hKQVrUlMbjTvc
	 sHerCVg3hN7tUR0Q5p+hMGXUGYDN0HzJxy+HfVvM=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hFfNn0QrHz6vKx;
	Wed, 05 Aug 2026 18:40:25 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hFfNm4R4Dz4y43;
	Wed, 05 Aug 2026 18:40:24 +0000 (UTC)
Date: Wed, 05 Aug 2026 19:40:25 +0100
From: Bradley Morgan <include@grrlz.net>
To: lrizzo@google.com
CC: davem@davemloft.net, inwardvessel@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, naveen@kernel.org,
 rizzo.unipi@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kprobes=3A_Fix_NULL_pointer_?=
 =?US-ASCII?Q?dereference_in_unregister=5Fkretprobes=28=29?=
In-Reply-To: <20260805161221.2428623-1-lrizzo@google.com>
Message-ID: <8494A641-91A3-4A4D-AE80-BB4E60249B92@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Thanks for the patch, good catch.

 
Reviewed-by: Bradley Morgan <include@grrlz.net>


Thanks!
