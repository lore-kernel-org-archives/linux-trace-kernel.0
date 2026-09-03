Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE037B027;
	Thu,  3 Sep 2026 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456774; cv=none; b=hr16GeNxlwszfwpzSdpmQjC2BV6dXdGY+1nHhG/UnFIwoehi4HUW7+/FS3bTtkp6K2gf7EMxZ/EaJROfLPTtKfzPLWip4qwVTOE4XBGcelSU1cbHQY/FEkrPO4J4gajowQui5o657gc1ACoa7bvS9iYi6e7moYYc55pkBunADog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456774; c=relaxed/simple;
	bh=JQGyVHr3ngEUTq6rIhXhcM5YRGBMfek4bFlPFCvkh8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eap5T5PVmciypfxM8HnGBk1yQOspjcS2XsRyFH1MEf0ek+aw06RtvUvzeUnCmsemkCksYY+GaIsgxvq2aUDBHgXxRCNshcXOFRmVK3xme5ckwX++KIHpv9jq7Adwei9x+B9Nm2SBH4zbqFBiSb1I4lBxFitPapMkc6GDYRXgvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=1AQkHQFa; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="1AQkHQFa"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3420DC0633;
	Thu,  3 Sep 2026 17:32:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 5D16080011;
	Thu,  3 Sep 2026 17:32:43 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:33:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Message-ID: <20260903133346.1bb085bb@gandalf.local.home>
In-Reply-To: <apmpK_QncDwqxE2B@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-4-vdonnefort@google.com>
	<20260903125621.36cd33b8@gandalf.local.home>
	<apmpK_QncDwqxE2B@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D16080011
X-Stat-Signature: 8u8fsj5gkpjntgtq413y8k34fwx1mxsw
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Xqhhf8KUHzrXwLLsltR9aP3xT+QBLMEw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=QXxAj8w86PLHh3uEPYmgt9bUzmhDhdjkBl16rZ2Kl9g=; b=1AQkHQFaDABhDpM+r3I+/HcipzsJV7UkOcYrvNtguWUqkxF+1ZPaRJYsUqvXWQu8Ng2ZTWROaYMayec1Ttu1My6Ptjgxups9r+UTt2FSaIbKFyj3yijK6KUQTe7DV7V65+BdmrsUW7Amzw+5ZMIVPfemQfoxCxv99FjdHDPWx8o=
X-HE-Tag: 1788456763-239671
X-HE-Meta: U2FsdGVkX1/afIZoCGkNRQuMj4Wlh6d8WOQlgZw3jBI11rR0fEAbJeKEOg4l+So2rFqCoyYB9Qq254CDcKZHXYM/fCo+hGV/KGB6g3YqIGNprJLLqC4FCA/8BzSBIydmTQDRU5caG2B7z4y3pDWMjrKtxdmtbckQRvwAv9dly3Ztuka2f5BMVgipOPkb7+eNtnSik3sbcOn1sE/6cPaAhvPIqVyYU/vJEwu390BG4OIWytrHDCfCs8cLBctutAQePS7Mh02y2OywJbEwFhUagNNWKoz1VxAzTXkM9oxZ758e+ro8FWGf+vKVqEbfdZoWmfb3R/oUX5P5/5RkaN7fELOSC10fC2xO2zfd9xivE9JD6fBYojWmAQ==

On Thu, 3 Sep 2026 18:06:51 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Yeah, I wasn't sure... It's so pedantic, we have no user with a small size :-(

Yeah, but perhaps it would make sense if an admin accidentally put in a
very small size (deleted some zeros on the kernel command line?).

> 
> But that would make sense to fold that into this patch, right?

Yes please.

-- Steve
