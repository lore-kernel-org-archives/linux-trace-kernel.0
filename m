Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F83D9028;
	Mon, 30 Mar 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880484; cv=none; b=GeIOQ2YiITCnvC2d4BSUliqjxtZGg1uBTW09gcmubKMDhIx9HT7a4Fk/RGbhGx1QLqTjgIQTOOrJeASNbJLTnPqanoTJeRRecmZtJBWWjOZAmqADGrRoFJUL/q/4fv/oBL7j5IFg5mubseimCoMhRkotANOOcSo11+B1eYHfiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880484; c=relaxed/simple;
	bh=xAIoNEL3mDSlD4DYV1X4PGf2FUFt1sfDFJZPfyG68ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaFn1BDHVHNHd/DIkzxlUoqNHQvXWN3rNc/kDPD9ms8ZHnt2DMcjLrskJBiiTDJEYy0T1H3KxbUqfCp6Aw97RCzOxhv2WL6ztnRl5IV7LSV9Rts2PJU0erbtes0j+2VG8qUDHlUeI0kBVGUiIjihT7TESIhF5QkYeG1GYUa83YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CCFDE1B8C1F;
	Mon, 30 Mar 2026 14:21:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id EA02520032;
	Mon, 30 Mar 2026 14:21:13 +0000 (UTC)
Date: Mon, 30 Mar 2026 10:22:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
Message-ID: <20260330102209.600936e2@gandalf.local.home>
In-Reply-To: <20260330024619.38459-1-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
	<20260330024619.38459-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA02520032
X-Rspamd-Server: rspamout06
X-Stat-Signature: bkkq1pdn4h9huw9dye7fwhzhirybz7xh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19BkyL0+Q1uqHfdVRtntg4ylBHdcdk5VhU=
X-HE-Tag: 1774880473-384258
X-HE-Meta: U2FsdGVkX19maVDiD0gh4GcfxAUgvEMAa/1aoymad/pPm3KxBvregGIsUux4epmjqyJ9IsvCXbcjfgbx825tLPTSstBngtxMtr1diqB/qAa5NOFmTcQOSBnu+DZrp8IivXGyrdmeyfFEO1ZcDO26CXW7PU3bTk7fyvtL1RRtSpnMoOYDog4V0raoFXu6W+bwwwluZ/223BX9R4iQ69O1B4tIsqrOtsD7UbUokHraER0B+lbIfWbCMmomKvwC2llCdvAAX4yedVhT6miKlImYFC4RBmbKjcgBB4IkTGbJF1Sg3MlfYZLSmfc6xMXKKymJ3KCr1InKl2c3VMCN2A3Hn5pGavAoa9Ko

On Mon, 30 Mar 2026 10:46:19 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:


Please resend both patches as a separate thread series. Do not send new
versions of the patch as a reply to the old one. That just makes it much
harder for maintainers to keep track of patches, as they are hidden within
threads.

> hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
> qualified variable-reference names, but it currently appends into that
> buffer with strcat() without rebuilding it first. As a result, repeated
> calls append a new "system.event.field" name onto the previous one,
> which can eventually run past the end of full_name.
> 
> Build the name with snprintf() on each call and return NULL if the fully
> qualified name does not fit in MAX_FILTER_STR_VAL.
> 
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> v2:

Instead of saying "v2", use:

Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-pengpeng@iscas.ac.cn/

That keeps the history link of this patch compared to the previous version.

-- Steve


> - rebuild full_name on each call instead of falling back to field->name
> - return NULL on overflow as suggested
> - split out the snprintf() length check instead of using an inline if

