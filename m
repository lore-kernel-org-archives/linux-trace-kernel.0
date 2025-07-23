Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A918D;
	Wed, 23 Jul 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229391; cv=none; b=dC7QOq/NNjuGS8zT44bQRzGv/VQRXV1rbaBTy6tJcVTNrk9ZULOU/b9KlNM4FUwvIZ/5p5M9grsbNMXu6rNlUMnj8nHldVCHHKIhgyRhuPSifOECLkSxVysBMI/tRtNZmFiGgnIBZEUUNqhgVmhqt7IQeF7ILHvwxjTiE8CY93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229391; c=relaxed/simple;
	bh=qqQcKk+7DKh3CF35H8xBy5D29BPNoW21fuLytiPMA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DROjymt+l9SzdNAHIAxkWODPUhvH12b8ndwuNKGOvTKQpGa1DUI9dEFaf1h8bCPXNqTDBpO1z2sYN2NdVg9jnyFwL+ZhZ03O4KXEGEkNUq/gSDigmHhKpUD5PDKAdFKG1ohjKFsxG3Q5PvISAyHP6yYRT9YV0pFVUyzWzEbLPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 977091A053E;
	Wed, 23 Jul 2025 00:09:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id F27142F;
	Wed, 23 Jul 2025 00:09:46 +0000 (UTC)
Date: Tue, 22 Jul 2025 20:09:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
Message-ID: <20250722200946.12840659@gandalf.local.home>
In-Reply-To: <CA+wEVJbwPPJ6_DOXChTCQygQrraK785WCu97jdVpdUqJ483mdA@mail.gmail.com>
References: <20250702143657.18dd1882@batman.local.home>
	<CA+wEVJYeDACQTO8g2L9_ZAM0mC2JwBm_pDahiGVmfc=c43caAA@mail.gmail.com>
	<CA+wEVJbwPPJ6_DOXChTCQygQrraK785WCu97jdVpdUqJ483mdA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m8yam4og8nwo64b49q9f8joemq4jw6jr
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: F27142F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/iRUVqFSbmNbP2/FRlJWUGOEvK2kQZ/Vc=
X-HE-Tag: 1753229386-441961
X-HE-Meta: U2FsdGVkX1/GAdpwlwivK2pYshBSFtap+X6mpNRrBw8lb1XcsHSEeVOtSsVMtXnP4aZLrSdKZ7E4FG1wdz/GG9h92t8+THYC/uw5I0LmT3vZSEVrzzR2vNIcZ6gnUovfVxN58biVGR2O11618hRGh3RD2iQQxxVyBYwsa/XDTc7dM6BCuhm1Gmq/qflul7s8aaWn94q6uPhev50ZAbwrrRZPqiTf+7GM4uEC5sD18aOnzKKnb2W0nSEkuxq2SoB7t3UhXFSc5w8l4PwQf+25l+Oi0rKUNGdTGpd/L484oNPTAitm1gKeg3WqxiIcJQIba/zK2Jm2zKI93OLgU0g36DS3emIUl/NTB8kJCEop7QojG/uOs+6f46HC1IUBEu/G3Wmjtj/82x4=

On Thu, 3 Jul 2025 18:39:18 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> Sorry I had a better look at the code and event_mutex is locked/unlocked
> also outside of trace_events.c so the modification below is not needed.
> However I think we could still replace the atomic counter.

Maybe, but that's unrelated to the current patch. I'm going to take this as is.

-- Steve
