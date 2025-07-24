Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8123D287;
	Thu, 24 Jul 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362888; cv=none; b=clZDWv+wUUTO1dJ3NtMP8MGRdLr96DbjCoHU26C1Cx7PwZvqu2htwryyk+CnX+7ajTsyknTFAR/ZOA+a4Z3J0CEgFcUUqQn02E7CU11eeB+7Qz72c/XbBM/3g6WmkyrWQogl1MFoa5HuRJKdm6k9VVYpie5QtjZTAbJ5I7+LaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362888; c=relaxed/simple;
	bh=AGeksOmyi1eAe26xCazCrUSZ/VFJkDTsgpgfMRQyYok=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P2ocJWT9K0HfN09KMRyYaaHSmTUzYwLGJ8ih6bRR4fI9Au3UV5fvga06lBh7c8a6mzQ4UOC89XAT3TUkVfsCRJ5tuZj64DHeI/WdDTE5Lvwim6d//PCIHoc8Fkxez+jhffoa1OnXddFuoCMpRorOYfeTUbpj+cyl7MwIJ6PdRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2gc4jBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2gc4jBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B5C4CEED;
	Thu, 24 Jul 2025 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362887;
	bh=AGeksOmyi1eAe26xCazCrUSZ/VFJkDTsgpgfMRQyYok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2gc4jBODFrJVo2+ELoGX1eK3v2kdfZUIiI1glGeEEyy+zT6F0Z0ppQCykf7LMl+p
	 jf1RkcHHlO5nZtytD3/gL0ybWOiiNv+o00rch7Maf0cmnUEWUb5b4AJ0NBK5GsNixp
	 VAFOAv71xCIVHWv0KRyJxJqCZxI04T4HqQUHlZeSs6rEDofO/s5Y77e/xjf1OHZltt
	 uOC0FWg+kqKjFuc7i6pT/LUO6Y9ZJok7QB4GH+8P7hA/t9RQ0bhLr2j+qKVKbXjeko
	 konfW7X8/Tr44rBvCVemCK3Levay1RgtJ8xSI/F1/f+ZbtKw01Fd/Jc1uEM59GBGdH
	 xv+Yg/z1rUQnQ==
Date: Thu, 24 Jul 2025 22:14:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools:bootconfig:scripts This file was missing the
 shebang line, so added it
Message-Id: <20250724221444.e59014b3cb0ab0123d6393d6@kernel.org>
In-Reply-To: <20250723235855.7e84eb3b5ed67975e1d16ca3@kernel.org>
References: <20250722225351.8811-1-unixbhaskar@gmail.com>
	<20250723235855.7e84eb3b5ed67975e1d16ca3@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 23:58:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 23 Jul 2025 04:23:01 +0530
> Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> 
> > This file was missing the shebang line, so added it.

BTW, I will change the title as

tools/bootconfig: scripts/ftrace.sh was missing the shebang line, so added it

Thanks,

> > 
> 
> Good catch :) 
> 
> Let me pick this.
> 
> Thanks!
> 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> >  tools/bootconfig/scripts/ftrace.sh | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
> > index 186eed923041..cc5250c64699 100644
> > --- a/tools/bootconfig/scripts/ftrace.sh
> > +++ b/tools/bootconfig/scripts/ftrace.sh
> > @@ -1,3 +1,4 @@
> > +#!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-only
> > 
> >  clear_trace() { # reset trace output
> > --
> > 2.49.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
