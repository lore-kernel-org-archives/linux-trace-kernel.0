Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C81B142D;
	Mon, 14 Sep 2026 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353614; cv=none; b=twNa4n4TBF/C1VVqBdMdsjkhJ69cUcNL/yDNB5Z7peuvhhRThubFk9+zcoUd4L+fTbAgFtSPGB7LLMyd7r8epiehWzf00DOw5K0DQhSizvYXx76X6IeanJK16rD154hnIva24z7HLHiOEFIAnJnzuxWMyM8qzEugLpq7FBv3Pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353614; c=relaxed/simple;
	bh=BAeAQFVRq5ftmseddP2cfYE2Qx7LuM68pktvYH1u0tc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=onI1earFf1X1ELccM0Ou546BTx6RDveA7Md8kWFGlugaHTXjOOv08JO+GipTt+pXmSvOtb17B3W9WmKaZCck9AkBiK4XmWngOk1c1zk4GyegPjOX8QB9CpTiODl1YT/DHrjigEmMJHHBo+v8bU0+2Q6xtuISu3YycTJwFBpmFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2ZLsA+Q8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2ZLsA+Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC51F000FF;
	Mon, 14 Sep 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789353612;
	bh=OvEaOOHnqfpkZ8FFeHibxz0bdzDT/zBsmLerOSLV8Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=2ZLsA+Q8tqDi/F7b5mlYmV4SExi0QZXzcexLjQOqtEUdafp4UqqihfebXzOlGLWjd
	 ygR5yj4Kag4rFzm32ja084YoNYsZtl/ZhH+yUtLgvXMQv87yabHsUtXoMO6cdhn3o0
	 07p1pN1u0vYcUDXyZ1w6elB3UWBMIPNxCvSnQWmc=
Date: Sun, 13 Sep 2026 19:40:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v2 0/4] bootconfig: Reject unexpected data after null
 character and cleanups
Message-Id: <20260913194012.284e4a9a13077c5c501919bb@linux-foundation.org>
In-Reply-To: <20260912224835.4e5f73b44cee39387554cc70@kernel.org>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
	<20260911155911.1cccfa39dd2e3c6e3a84e03f@linux-foundation.org>
	<20260912224835.4e5f73b44cee39387554cc70@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 22:48:35 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > ...
> > >
> > 
> > Thanks, I've updateed mm.git's mm-nonmm-unstable branch to this version,
> > 
> > > This version removes redundant buffer copy in init_xbc_with_error() [2/4]
> > > and moves BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h[4/4].
> 
> OK, anyway I'll pick this series to bootconfig/for-next.

Oh, I didn't know such a tree existed.

No probs, I'll follow my usual automatic practice: if it appears in
linux-next, I drop the mm.git copy.

Often after checking that what-you-got matches what-i-got and
if-not-why-not.  I'm not a trusting soul ;)


