Received: from mail.thinkmo.de (s3.thinkmo.de [162.55.237.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42171438482
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.237.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446207; cv=none; b=f+Qic22rsQxPO5eo/Sp7fFbqNl1yi5Vd8tuakWckx5B6GsW+SLUUGkQI+aaqISHLjuTTYwOIqu+OXUYN4R7C84mrOt2TLgE4CRFr0WMu5pyY8WYv9171oE/pAqbcRp9vdzSNanzK9yDhk1JDNpevrX0K5Hg7/1TkMkxvvEOiA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446207; c=relaxed/simple;
	bh=w/JIzLj9EiwLm1c56OQ3Jlvo9W9At38kii0twBLVLKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArDczNrHCMzj9HrF9xaGzkowdGIkA/KdHkI9yUTcN+nGoo9WLxDPHGL7q2+46J+iwNDiRqbcRPkzEkDTu2wAAzezSA25ymIF7ulkShQjjKcn8PQeI0bS+5Xtt65RdIWBnEOozlMx7iMMtERLgsxIMk60/FwGQssqAPgrEeAw16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=fail smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Eb05+Rga; arc=none smtp.client-ip=162.55.237.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Eb05+Rga"
Received: from localhost (localhost [127.0.0.1])
	by mail.thinkmo.de (Postfix) with ESMTP id 4gvpV35WPCzyf1;
	Tue,  7 Jul 2026 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received:received; s=mail202007.waldi.user; t=
	1783446187; bh=i/x2FvR1u4Pok8o3QQiGB0trDpEqq1SoD7BN0kE1YeE=; b=E
	b05+RgaCvsEvZNbuwiUC+/3/jJgSWKPZfFziGMT1E4EKaUv7SoXUjaZL+aRS//fw
	mCOeV/OUxAgP7iyVqliGQH0l8kuZpIlGMQ2vrfTKcswRH3zLhGaqB08GdY5FYfHF
	ccOYt4/4ET+i7vrmeSxMOJJEh6du7cNlK4pJ2QmbX5e7BJIazEqHtZfMxiREMfVy
	Q6KPJtqxTXsYpHmNc/hPC1RjQJDDR0/GTXApf0rP69TRltiZcYPxF0UOclZO48Gr
	zdmvaSRYr53shxq02pb1QSHvkzwDUvAy7C08nIDCu0iOa/DHisRdK4cJybbV9XyM
	5B/8SyRJJswCpjzqfN4SQ==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxCn4NY2d9_G; Tue,  7 Jul 2026 17:43:07 +0000 (UTC)
Received: from shell.thinkmo.de (shell.thinkmo.de [IPv6:2a01:4f8:271:3f5c:0:22:0:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.thinkmo.de (Postfix) with ESMTPS id 4gvpV34r8XzyVq;
	Tue,  7 Jul 2026 17:43:07 +0000 (UTC)
Date: Tue, 7 Jul 2026 19:43:04 +0200
From: Bastian Blank <waldi@debian.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: Also link in ctype.c
Message-ID: <hkao7qatojfeiv2kytbcfbvbjyb4pagdfv6ghbwq7mvda7gpl2@32lkx662we2r>
Mail-Followup-To: Bastian Blank <waldi@debian.org>, 
	Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org
References: <ako2S4mzIqWwYuas@steamhammer.waldi.eu.org>
 <CAP4=nvTH5HhUk19w06aH6-xqWGOUQKesGbKCfvgpwmefLom0VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP4=nvTH5HhUk19w06aH6-xqWGOUQKesGbKCfvgpwmefLom0VQ@mail.gmail.com>

On Tue, Jul 07, 2026 at 12:22:37PM +0200, Tomas Glozar wrote:
> Thank you. It appears that GCC LTO drops the symbol use of "_ctype",
> so I didn't see it earlier. With removed -flto=auto from
> Makefile.rtla, I can reproduce it:

Ah, yes, we override LTO to disabled.

Bastian

-- 
There are certain things men must do to remain men.
		-- Kirk, "The Ultimate Computer", stardate 4929.4
