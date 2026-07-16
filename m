Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F636175A9F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183289; cv=none; b=n84U/vZmUnbfJ095Dxyt0WYRvF54g0jjfhjed7ZEcVEWnDTZ0b4I35TjrQj70TrtXvEi/xf/lyYKqDlTj1MUly2TfOvAuVahvYJHGnilLEEuFcyb2SembjCshgbHV8hrnbAAzr9mqgWvh6waN48E9YobKsd2O32LUqufG8TNQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183289; c=relaxed/simple;
	bh=+kFonBEV1e3qG024h8bhjMQj7iJdlf4kNAtl6qXWQiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=PmqCLMDVrzl4YaH/RCvl6vVFdNXB3i8kN0tKX6dLLEB5vGEmb/RTxwULnBj0tFAv7IHwHvWO9TusqlRizh0soxQTnZIT5/8TMSL5XYtHfAemNh40zSHL0/m48a7I49fmA/TWiLZBRK0wajBxr8bWI3ya0GN0MSrTdoi45EWjq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OFrISs0e; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OFrISs0e"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260716062755epoutp02eb7857fd0a0ef6a16cc035a3e5e88055~CsTx2qX7V0777007770epoutp028
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 06:27:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260716062755epoutp02eb7857fd0a0ef6a16cc035a3e5e88055~CsTx2qX7V0777007770epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784183275;
	bh=1LRr8qbxCFq3LyyTeFaapVfw0Qd3aBBVgFsBUPoczUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFrISs0egivwAHythBeYVSF9KzFcOYWel1nsRA48liAm4Y6Vpw3Gg6EfkzNnBSnHE
	 wHunO2FsD8K4N4NIZ1j6ro44HmDH98sgLL2PUOwM+c5K/JDuzAdNqS9eyChazUWLVr
	 hW83WTQcG5+gryNyYNZU/+WUWJuGeg6eH+0zBhEU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260716062755epcas2p2f9c99f19a1aadf1d21481dde0a55dee0~CsTxaF0ZS2203622036epcas2p2d;
	Thu, 16 Jul 2026 06:27:55 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.205]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h134p5sh8z6B9mD; Thu, 16 Jul
	2026 06:27:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20260716062754epcas2p28bb2ffaf636702118a6543ff32a1bf45~CsTwXIhue2786427864epcas2p2G;
	Thu, 16 Jul 2026 06:27:54 +0000 (GMT)
Received: from KORCO121415.samsungds.net (unknown [12.80.207.147]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260716062753epsmtip183393bf6ab3fb57f6e6a098a6ae91d5e~CsTwTkQND1549515495epsmtip1k;
	Thu, 16 Jul 2026 06:27:53 +0000 (GMT)
Date: Thu, 16 Jul 2026 15:27:49 +0900
From: Jeongho Choi <jh1012.choi@samsung.com>
To: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org
Cc: jh1012.choi@samsung.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ji2yoon.jo@samsung.com,
	minki.jang@samsung.com, hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-ID: <20260716062749.GA904@KORCO121415.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260713102343.74baba5b@gandalf.local.home>
X-CMS-MailID: 20260716062754epcas2p28bb2ffaf636702118a6543ff32a1bf45
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----VEZ5F8a-Tw2lt7MpxXhYJFdwE4V05ef.Sd6wohvePyBfHkGd=_200ca2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
	<20260710083357.49e05ff6@gandalf.local.home>
	<20260713121659.6c8549331474337511c4f442@kernel.org>
	<20260713102343.74baba5b@gandalf.local.home>

------VEZ5F8a-Tw2lt7MpxXhYJFdwE4V05ef.Sd6wohvePyBfHkGd=_200ca2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jul 13, 2026 at 10:23:43AM -0400, Steven Rostedt wrote:
> On Mon, 13 Jul 2026 12:16:59 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > I also kept this around in case it was needed. Looks like it may be needed.  
> > 
> > Hmm, it's not clear whether this is the result of a scheduling storm
> > caused by kernel threads. But maybe worth to try.
> 
> I don't see what else it could be.
> 
> > 
> > Jeongho, can you try this patch? Or/and you maybe also try using
> > mlock the LMKD process memory which is passed to trace_marker.
> 
> Yes, Jeongho, can you please test this patch and also see if mlocking the
> memory used by trace_marker would help too?
> 
> -- Steve
>
Hi Steven adn Masami,

Sorry for the delayed response.
I would like to share the current situation.

This issue occurred during the verification process of our latest Exynos
chip development.
Unfortunately, this problem is not being further reproduced.
We have continued testing the unmodified kernel on about 40 devices for
roughly 10 hours per day for approximately one week.

Because the baseline kernel no longer reproduces the problem at a
measurable rate, I do not think that a test with the proposed patch, or
with the LMKD buffer mlocked, would currently allow us to determine
whether either change improves the issue. A non-reproduction with the
patch would be indistinguishable from the current baseline result.

Versions that can be deployed for verification with a large
number of devices are limited to official release-ready versions.
I can only test the test patches you shared by building them
individually and testing them on the few devices I have.

Therefore, at this point I cannot provide a conclusive test result for
the proposed patch. I can still perform limited build and functional
testing on a small number of devices, but I would not be able to verify
whether the patch changes the reproduction rate.

Thanks,
Jeongho


------VEZ5F8a-Tw2lt7MpxXhYJFdwE4V05ef.Sd6wohvePyBfHkGd=_200ca2_
Content-Type: text/plain; charset="utf-8"


------VEZ5F8a-Tw2lt7MpxXhYJFdwE4V05ef.Sd6wohvePyBfHkGd=_200ca2_--
