Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08C310779
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136941; cv=none; b=Dlcae9J52YlUpIzsEQ0VHt+bS3OgsMKhfmnfjm7CVDLF6xL+XeG9fY9VdNBaQ1vElzDhdv/GOSMq0EU1yKx/gXIv8jv8CBhgZuLvw6D/0eADKy1tOY1mA0M3bA+cnRPhaSS+QwJgkYADsU8zmWXfbN2tUkcZ6ZxXXd+brK7TdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136941; c=relaxed/simple;
	bh=EsGpJx+A4iZFjKnjuvKzJ2MLNIB0DzYHSNMjgiZcrRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BD1uzwrE+ME4E7jpulZh3DtzyhM0bl+2aeEei52UXVKTLTIUM+iZ95RrNorzjhr6qvU0U6t4JIm+58Ns8knrIYXJIw1Cd26u8z8zpWLGU1YV9HJ9bXuqGANvGh73IXtFAptCiPgSuubG/cBJkPiwoK4+olGC1thGeh+SqGKkxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktR98C6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktR98C6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894201F000FF;
	Fri, 11 Sep 2026 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136940;
	bh=VdSWB4ThW/thDQH3Nm14kGTV2FuUTMlVcByz6KwiL0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ktR98C6gTcuoZALNNdTPL+caXqX9TzLxxRmnaXbWV93SDMeiiP8JSFF6d+wLmLXtj
	 0mv89CP0uK3JcUky1F0hCot9iMwEKLrsG/cGr0AWJqttUeERtfHuTuTSiq4fq3g25n
	 sQGt1E0eb7+ZUm6nQfjqcHwY6OpgY/jCoZ1FaSnqb7dhYBpxxdwJkb8lUnlWzLnkji
	 1PgPZ3PEogSHfGi+oC/5+qN6C6/JCoeJBQKz5g06JeWo7BNyhPvEGVlBUiKtNVBo+k
	 gje4B6E8E2TDhWmpTwV+mUmx8oodbOaaiDMK+qlM7+o+WdQ34Ucw8i0hxzx0Lm+Mlg
	 QUJGn5E3bLvDg==
Date: Fri, 11 Sep 2026 23:28:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: remove redundant assignment in
 xbc_parse_array()
Message-Id: <20260911232857.5541fa52d6016a1bdf36de03@kernel.org>
In-Reply-To: <20260910163051.1973775-1-ekffu200098@gmail.com>
References: <20260910163051.1973775-1-ekffu200098@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 01:30:48 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> After the loop, node is the last array value that xbc_add_child()
> added, and xbc_parse_array() sets node->child to 0.
> 
> xbc_init_node() already set node->child to 0 when the value was
> added, and node->child is not modified after that, so the assignment
> is redundant.
> 
> So remove the assignment.
> 
> No functional change.
> 

Looks good to me. It seems commit ca24306d83a1 ("bootconfig: Change
array value to use child node") has replaced next to child by mistake.

Thank you!


> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  lib/bootconfig.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index aba11caf6903..12dd259d490e 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -833,7 +833,6 @@ static int __init xbc_parse_array(char **__v)
>  			return -ENOMEM;
>  		*__v = next;
>  	} while (c == ',');
> -	node->child = 0;
>  
>  	return c;
>  }
> 
> base-commit: 13e8b7707efcea3a401d242958ba0a392f227847
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
