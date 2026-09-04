Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028018D636;
	Fri,  4 Sep 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501203; cv=none; b=maUyKB5AndOtvxjqNSvcZIGRBb3bKqfBfXv66evroE6gSO2RGxudC8XXbWnUxNGwwMFLd67/HlWKQeGwvcTM/KSHrLN3q42+0N6RRRjvbFed6vSpKQM1RvuzVY8/CVXKLBRGtQYHwIbrI5fDWQMM9jC2yrKV/7XNaLOZLuK+93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501203; c=relaxed/simple;
	bh=+hrHgRE03GI7Nwzlr3bgpp9ku+ShECfklP3pErZzJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs8eogboLn/Iag3i7k/3dfVvCMNKVp/HLxn1RpQ+/X/SnrQjjUAPsgzdPFgJsMO5mdAxCPHorgDxqvjUEd/qZ0AfTwG8ahOBiSSQBAglp9Rq1qgJk7QXYKJ2Wn/d++t5GgV1WIEv3iwCFg1wFIqhsS97hYcFLE6X5+w8rQmRjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTQowtzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTQowtzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AFB1F00A3E;
	Fri,  4 Sep 2026 05:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788501202;
	bh=+hrHgRE03GI7Nwzlr3bgpp9ku+ShECfklP3pErZzJuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xTQowtzcqJKNo3G8g1fiAFOnQWyy2O3LLg3Ix5UOFOeOtlDDmfKUr9Op5/Kq44nGQ
	 R2vAKqNphMe0QTy9Ltw77v9I/a0A6KNH73JPMWYohUJ0nKQJXNs4IgbJRrVuiRFQCP
	 wa+2GJYunk0Q5XNlvlOch/ga4KVB3VR47mpkzzr0=
Date: Fri, 4 Sep 2026 07:51:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <2026090413-bullwhip-tarnish-64e4@gregkh>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-2-30025465f38a@linuxfoundation.org>
 <20260904052208.DF4211F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904052208.DF4211F00A3E@smtp.kernel.org>

On Fri, Sep 04, 2026 at 05:22:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Tainting the kernel unconditionally on any sysfs bind/unbind operation marks legitimate, standard virtualization and networking setups as tainted.

That is not a "standard" setup (or really shouldn't be, it's an abuse of
the api...)

