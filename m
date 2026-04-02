Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BC3F165D;
	Thu,  2 Apr 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147281; cv=none; b=SqyDxxv6QMrC/upEaJKPbaAhoFXzYY8Nd10sueXaQuSE18KTpZmx+PrqEcPsavhLhfWLSuNfovCqiFLT0Q7D1oyGVgEWYvEr5P1JkILQE528EjXRFyF0EHCgvx6ovGsxevQ4NiPHdc2s2IgmyzWZDeWiS2Pze99gGUrK00nTIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147281; c=relaxed/simple;
	bh=m2i9dmF0MbU0LqKHLxbRYtOWLJCeGS864571UlVktvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oU5frHHxB4CUMLYnVklOLIIrcHQX65CrOyx7GNVbn3Y+9WW9CqhI5fbVY6u4QhEDDAj5EGH/2L5KW8vhjVBEOup0CXp4IPnRd1u9DgupNJEZBR4EPTifkvYnP80r7gFpSBkhYYjcyVH4uIdhao2F0oeIpD7MCwejl+bjpR85Fd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 20D76E1980;
	Thu,  2 Apr 2026 16:27:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 6813820035;
	Thu,  2 Apr 2026 16:27:51 +0000 (UTC)
Date: Thu, 2 Apr 2026 12:28:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for v7.1
Message-ID: <20260402122854.2e47eeba@gandalf.local.home>
In-Reply-To: <20260402122634.4d750f2c@gandalf.local.home>
References: <20260327150237.405973-1-tglozar@redhat.com>
	<20260329122202.65a8b575@robin>
	<CAP4=nvRZ2iEVxSgwHwumgonrhdvkYiG9KsCh0S2kwBwnemMi6A@mail.gmail.com>
	<20260402122634.4d750f2c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6813820035
X-Rspamd-Server: rspamout06
X-Stat-Signature: otfe8n4wm4xd3d6gxf9pc93jo1f88apx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bQP3ZGpDlovpZXSzuuf+AYVEc33DJMmc=
X-HE-Tag: 1775147271-284265
X-HE-Meta: U2FsdGVkX1+BerIxixH3h748U3jGUr7e9bTh/e5e5hpWFEnrgE39wIgAsXAz+IcJARzRJtzrhvk1jBkhIYe4rETIdqvnNwvr+thMSyODmh0Bt1lstJHirQcRUWnHcufoWaTSZVEd53iV6Y4xb0BPEC7vbLPal7K7oXonRp/AZzKBliF+b2YlK+TNOarOxiHgQ+CYvfCVWY3Sx4vdEy2KNUvQLIi3H0+ximlDw096SQKrLtB6aF/T9JznnuLDi+WgxV/CT41nu1FVa687IEbLqU7xdRTLAj0mQi3W23PXLA3zQrh7JchaGRXVxXdqdIAPYYIrIO8Bhke8PFlE1nG23aeHMwDe4yZXHbDfPLVWpw1F94+fAQBuw0QmGzCxoGoM

On Thu, 2 Apr 2026 12:26:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is fine as is. Linus is used to this. He's even OK with minor merge
> conflicts. The only time you really need to tell Linus about something is
> if the merge conflicts or a merge causes something to break but merges
> cleanly (like removing an extra #endif)

In fact, Linus actually looks down at rebasing. You should only rebase if
there's something really nasty.

The code is already in linux-next. Which means it should not be rebased at
all.

-- Steve
