Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A725E469;
	Tue, 30 Dec 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105648; cv=none; b=AbxkrkQ69WevxnblpZApGJQVdbr57ePPgo3ibU9QIiKd1tF2wdy6/SwhhxUHupkftzol5IBxJxBK3WgKFi2Bqs2XPYalsgbexaI0k+TN6HsmM6FfcGTDOiBEPMgXNRhjCj/o9VjpxIXvjLxaKWhO/3OBEIdbEM/LGr1+FTTCgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105648; c=relaxed/simple;
	bh=YlgB5uE89uhXrhPZhZ2B5RhhPA+v9/U/nkvtYJjuFPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7UiHcW4H9rx5gt1ZOGtwdw8cmvGiEZBz0Ke7Rq+USXIri+pkfbZ4VOKIJ6QrES7nf7AOxe9RIvoFjOdP6toTcVbz0eET0pAKb7xdzKI7vXarpO7IP5JVJfjz9O4UvkEQ3QEA1v5TFYCJqNDWk1fZNmOd+qCmYix80GKk+VUtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E28821A0097;
	Tue, 30 Dec 2025 14:40:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id F1C2B6001E;
	Tue, 30 Dec 2025 14:40:35 +0000 (UTC)
Date: Tue, 30 Dec 2025 09:40:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Shubham Sharma <slopixelz@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rv: Fix documentation reference in da_monitor.h
Message-ID: <20251230094040.551847f4@gandalf.local.home>
In-Reply-To: <5a8b1ef45e775d4724237057f60ed49cf5432ae8.camel@redhat.com>
References: <20251230075337.11993-1-slopixelz@gmail.com>
	<5a8b1ef45e775d4724237057f60ed49cf5432ae8.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: on1hcyyf4e1w77kwwwoi7ud7hkeokdp7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F1C2B6001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yUAO+mSjvYHCmwsJZFHLCJJKi72oLbEo=
X-HE-Tag: 1767105635-503887
X-HE-Meta: U2FsdGVkX1+8Z6eHlz5YqFr7p7f63bm8wvk1nnl01VlKCgR6e/JfOloLQwFk7VqUUFzibEwLJx+Qswa3S097TuhShLxZq2MAD3t7z+6HYhG1+Ly44/iDpPRjDpm8Y+rx251D57bNU0DekxTngzPNo7Xka4/YxbfitnVBOjAKsvyZEDKP22ylr2pf27nyZ6YKEse10Sz6MFE0c3g0KwNtd+3oHKnsKIKLOdYRfRUT9Rx4dUASb+HdUbiP7LC1JfN7ZTsfw9vhmn5Lt7xQSWfxYkQdWShHu8vsDECmkdcw5OrRuV29V1RhOKNcK1ujWLabd+o40LGKZzWXxT7rO+PdNKtkk2x3BucKOm1JE024iZ7UuS9T5BfRAh0or+/35PoTqjZWqD4UmW4=

On Tue, 30 Dec 2025 12:29:13 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Looks good, thanks! I'm going to apply it to my tree.
> 
> 
> Small note for next time, although it doesn't make a big difference with this
> tiny patch, when you send a new version after getting a review, try to propagate
> the review tag.
> 
> Simply copy:
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> (or whoever reviewed/acked) before the signoff in the commit message.
> This helps when reviewing larger series and when using tools like patchwork.
> 
> (now you don't need to do it, most tools will pick it from this answer)

As this is sent to linux-trace-kernel@vger.kernel.org, you can use
patchwork to automatically get all the tags of a patch or series.

When I make a new series, I first create a new git branch based on the
patches pulled from patchwork (b4 works too, but I don't use that).
The patches live here:

  https://patchwork.kernel.org/project/linux-trace-kernel/

The old version of the patch:

   https://patchwork.kernel.org/project/linux-trace-kernel/patch/20251207205546.73946-1-slopixelz@gmail.com/

If you go there and hit the "mbox" (for single patch) or "series" (for a
patch set), it will download a mbox that you can use "git am" on and
patchwork would have added all the necessary tags to the patches.

Then start with those patches to make the update for v2, and you don't need
to manually add the tags.

Just an FYI,

-- Steve
