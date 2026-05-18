Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DA3C4562;
	Mon, 18 May 2026 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094186; cv=none; b=XwWscNzUt0FYVJQ1lGBxuWC6NEpa+k7C2XlAx2QipYA5lrbYLAobWeA/X++sRdyj3jb3vnzgE+rs24MH26L8uVb+DKNwL1ZW6mKRUZea+lrCL1eLit/UEAJcv7+6Y0nI9xZKEEvrenDafDa9BXQ+x793fgWFPHsekwfYf9gYTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094186; c=relaxed/simple;
	bh=Jh5IxonEJALiRE/tnRe3JKZYYBUJDpOK52LVq2KLcjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/ZM+mNV6sRtetqBFp0P/0J/EpNoHf0rXrs1GU2UHjLwlDmLXJWxFImNd3XmW/5Rxgv3jmNGhxBletRjkNSx1wNHLYcAvIvkG7zfeODNYhcIWAayejiUDfhkty976K9FQgi7bmLhCESdK2xqt6Y+bswQMDlm9ZfaX4yU6MkJxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7teaVpe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0O3mD+v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7teaVpe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0O3mD+v"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779094183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtyfGl/PA7tYdnYc/WGnqDLLE8BjCWV5htPWBwjsEsc=;
	b=E7teaVpexSy/kld2tr0KTSG9GHAficRorEsCOnff20osFpmI1RBcaJNKMZ+1t45Ndk/5TK
	s4VJ11QgHGgRdoP+/kzslBw9HpQuWht4Q+LcUhYMCyAs+vy9zWUK7lcxRUmRd8hn2YPctH
	nZ7B8e4ummICVmuoRwaEwTYjiJcQBvrpBQc9u/bEAfIi6brtE8rL9UixqD/14BejJxaS60
	8ugWhG/vdwUeIIsyD+yCf1d/1P1sNS605MEX93iQIopgpOySLlCKXSXApTKhRclxTAlPP+
	j/OL9Bou2LPIwnDd5nfiXD/DgXo0TKQ1ehPvtMsDkK58fUy8qClblt8PfUQqFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779094183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtyfGl/PA7tYdnYc/WGnqDLLE8BjCWV5htPWBwjsEsc=;
	b=E0O3mD+vAmNkS47I4uPCMUjKy3lqc1jzXtwRoYMzkBMnhbM5Rb3I2gr7Jf5cWZ4QPgjIqt
	GTDpGx1291eyR2BQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 06/14] verification/rvgen: Fix options shared among
 commands
In-Reply-To: <20260514152055.229162-7-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-7-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:49:43 +0200
Message-ID: <87v7cl6r14.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> After rvgen was refactored to use subparsers, the common options (-a and
> -D) were left in the main parser. This meant that they needed to be
> called /before/ the subcommand and using them without subcommand was
> allowed. This is not the original intent.
>
>   rvgen -D "some description" container -n name
>
> Define the options as parent in the subparsers to allow them to be used
> from both subcommands together with other options.
>
>   rvgen container -n name -D "some description"
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I didn't know we can do this.

Reviewed-by: Nam Cao <namcao@linutronix.de>
