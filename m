Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27396446BF6;
	Wed, 14 Oct 2026 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005147; cv=none; b=oDFjv+pUSaFnuxGEdmwtdJLHPFoM78n7E0vkM67u9YqdH0zXGgi7y8Htyi1lSbG8FeZDbHyvo4OJcaz5tzpeOXyfgZ4nPagOwQnw1AWnYDOMjqMlj/gHXjiA1LfsocFdIMsORz7UKKSVbvuMKOmDJm/PUZ6j2bWjigoYJDtnr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005147; c=relaxed/simple;
	bh=3Yt8JG7kLhGp5X9p+EnvxjJ8XF3dg5/DKrAi22K/xu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh2q5vBreo5Js8l9LJbQkywuwuj5CrNFg1k8yLf9pmDzaQR+rQbJBJOp3NPqPjVJ9vAMlJJyEJFyxou4x2rNqL0o1tnH6PrpJv1v+lz9uEFJnBi/vgQuWyx/aktVyaGQ7UOVmIoKkJTX+vL1Sy3d5Og0H3caSdND7VhdvlNr3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fsXECfeF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fsXECfeF"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E29120B7166;
	Wed, 14 Oct 2026 12:12:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E29120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792005135;
	bh=355K6LGeyfVGWmUeL4IXTXYSycURQhiaBcgGf7o0dC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsXECfeF/g+kmjNC01uJgi0efV9aYeZpLRdrsvfT2oN58oPwyb9WFVZpkIz9Vkvhq
	 DddWdAWaK7zsrkI9222Uw0Vu3FR+pQEUdkWI36mdh8KKfmborOxCmzIHrh0rzLsJO4
	 F9zAISRST+kHOsnvK1Zm4FQ95su6F/6pZ0q2f7Ow=
Date: Wed, 14 Oct 2026 19:12:15 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261014191206.GA65-beaub@linux.microsoft.com>
References: <20261006083825.2bbeaef2@fedora>
 <0499A842-AA79-49A7-AAB5-47003DD799BE@getmailspring.com>
 <20261006101427.25e0f8f7@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006101427.25e0f8f7@fedora>

On Tue, Oct 06, 2026 at 10:14:27AM -0400, Steven Rostedt wrote:
> On Tue, 6 Oct 2026 09:42:39 -0400
> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
> 
> > So in this case the state being duplicated during fork() is state that
> > the application itself established. That's why I think propagating the
> > allocation failure back through fork() is preferable to silently
> > allowing the child to lose that state.
> 
> I agree.

Great, with that:
Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

> 
> -- Steve
