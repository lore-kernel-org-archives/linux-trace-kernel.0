Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C2136A;
	Tue, 17 Jun 2025 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203166; cv=none; b=byBBq6tm370Q5CEU3UaM66EyKis3U8095To5zR2JhoYfFhyC9t6C4Kcx/Elb+V0FM6sYSu5Xbg0kGds5UK4zenr9OKIwnxAoB665Z6nAKaDbjF/eC0oidTSMh2I4ZcmdJrFoafjOYgv9F76Hj4+r5KcjD82qnZeX9q7tNGsKCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203166; c=relaxed/simple;
	bh=Cmo2gfCSY2IOU3EBYm8tRgNqy6MFqagqNSoNv0PfM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbFH9ZcDIpEgi+uHmvb8cgmCCzLtEikZat+xuwSVvZcNMJNGJtBi2K77p9OLAGWI691pEFqJdfQAjJtNtm5LUKl7uHZAe2u+RbMfJw/9szIwJZqfnpKDHcBiyuUZL9XPjWm7x2VBa2Hwmmx8AEWD+nQZBCP8opQQUsnH5zDneWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CE47F1612CE;
	Tue, 17 Jun 2025 23:32:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 9DF073D;
	Tue, 17 Jun 2025 23:32:36 +0000 (UTC)
Date: Tue, 17 Jun 2025 19:32:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250617193242.394edfc9@gandalf.local.home>
In-Reply-To: <20250618080554.15415cc4ff7535554850c689@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
	<20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
	<CA+G9fYsBhS+yUa5KSzGDzqPhbRxW5p9_qLjt5taecAcguj7oNA@mail.gmail.com>
	<20250618080554.15415cc4ff7535554850c689@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9DF073D
X-Stat-Signature: mj4ygokcrgw336uotm664h4mxxhxjh7e
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/RncOSInQYoMNFCmaEIx7ApmUQuON9NWc=
X-HE-Tag: 1750203156-490063
X-HE-Meta: U2FsdGVkX19FeYJmQQAOXmOqfl9jgVXIeyeNGTyXyuxc0mKBmYBhcy1pd07qj5XyUc9b3bjsIxmNGWmGvYHz8Gx4UWMYa0lHxf/i+Oa4RtsgamSo+lAdvy6nAZKQNReod9U5nF47FP6+bfHq/zzy5nloh8aDoMt8gN2+HvLxGQpwb6vFUMc3VwKW4VPwpIdERR3I+tm86XbHEEEmcQRMRbX8Vd0bfQc04h+wapfyFd5lXYy6dAlCry8bLTs10j0eQCSVEZQlLe9OvzgTuZ++A0dXbYRRQPW/eteXgs9DIKp3GJ0L/6MlXR19iYoduX3Sf5oymKCMMN5wSouFPzzgc/1MLIABl4Vrqi+8D6MC8xoiwT+gtY8eFIBE244XdjKMbDYd0ZJEKpkfargHjrgquA==

On Wed, 18 Jun 2025 08:05:54 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>  
> 
> Thank you for testing!
> This is a good chance for me to setup LTP environment locally :)

It's a beast and so far, it continues to fail to build for me :-p

-- Steve
