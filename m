Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD934DF4D5;
	Wed, 14 Oct 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982370; cv=none; b=cRPDOyTfIZtgzXiP9blaEz7RQ75J1pfrWFrCt8Po6DvWISo+clNctlN8TtI//bWVpIR9Yzy1K96cT08KuobPdwzwszefsZXGA0XW6J2bGVEbk7WEimQc/8GpV+tmEPomI9hsWb8eNYjW/aelFxswKCgyHxn/0OpKgChEXDskJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982370; c=relaxed/simple;
	bh=3sTwOvgriNAkxKO8TqnSXTOyDdaMDvi2zp31gVBDo10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g03Vl3ZYE2GswltXmwCBFcCGZC3VW8DgXs6u8TuqIwnI9l/vFx3aMdpTt4gOy5xu4G/dhazrNpK/Dy/yQHJ0xTxydUh67P+RiarYE12xXeq5YXfBGbDx+85AtET/1yDdb2rp1QAXwHaH8X3apsX3v7EUvkxnobI3UQ7ZpqHt+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=TXOGabp1; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="TXOGabp1"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1B5AAC053E;
	Wed, 14 Oct 2026 12:51:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id E917420024;
	Wed, 14 Oct 2026 12:51:55 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:51:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sang-Heon Jeon <ekffu200098@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to
 error message wrapper
Message-ID: <20261014085156.2d888407@gandalf.local.home>
In-Reply-To: <20261013212351.ce16d411abeb7e710eed5157@linux-foundation.org>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
	<178913599508.248794.10388592925402087434.stgit@devnote2>
	<1dcf2ee8-02f7-41af-b1f4-bff3a16a2c90@leemhuis.info>
	<20261013212351.ce16d411abeb7e710eed5157@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1uiir9pnbqo35mdh6tdeds9keo1uq7wn
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E917420024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+b3wfe0omgBjnqULDGpD59Hgpzyj3TBEg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3sTwOvgriNAkxKO8TqnSXTOyDdaMDvi2zp31gVBDo10=; b=TXOGabp1/Dmh/OCeExlO+kQQquKiOUcZ2WCZEt1lZhyEnW9xorL/NVw3nb+htd5lzdipwsVAdYXcVywUpJr105XRwQWA8+OtBgdWcE1wJwIPaQQ1KJX/cHRv7Z+hN/G7n7ekEACgfwLzsGZLQpRtwgzZBmOUamfwUWKt7E3vJQo=
X-HE-Tag: 1791982315-44159
X-HE-Meta: U2FsdGVkX18K9udf/Xf+1EeQJR4TjeojlXlKYgOyGn85AOTsBbVHSimyk4/czDotc757zOhJxy71wEK+AjPVmeGWiA2WvFpZLqLIyCBDVcMt0RiP2OVYsqc315ZXtbQj+0fo7VNDPlw+UMobNqbf5PiZnI62H/cMCxB1d6NpHhooPXShctirds1ZcIh3kNag0CD9hiOAUfVG5YNtBJjH26YZog22lmRvMtvaZIEU8ASDyM1oZu+mCd5nXRM3JPddjDXXIdXLFVz0iXgLQewaHOXhrANetzksFpoAA5qfKdFaQu4+DKwwEjN5JolUAwzdtYxls+dp7nCcYF91KosPpl0IxhZ/9WsvErF/hEnE32mPEBLPlvnaorYL3d7PD1cB

On Tue, 13 Oct 2026 21:23:51 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> I was surprised to see bootconfig patches in the linux-trace tree, but
> it seems that's where they're hosted.

That's because the bootconfig patches were originally created to add more
complex tracing command line options.

-- Steve
