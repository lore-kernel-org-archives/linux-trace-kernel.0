Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1A37D113;
	Mon,  2 Feb 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048754; cv=none; b=CBnB5t9qeEkKw8jGz+UVoPTXAd/cm35MlgdmfGra3SN3PYEOlUa7qSj+Uzp0a1+UUsrKgeQ3LoLVxTqPlmmIdYDWHhSRndgxHiu3KkXKqU/O9sQ1S3g8g/5LuhLfwxcdukaFQuioXDb5HMWekETKfigcoHB9zf05R+3OLk819sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048754; c=relaxed/simple;
	bh=S/sdD1LU6BPJSO9apEv7Z0jcJ4/re2NIBdpHU4l3CGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUxkJGecSeYyXs4eWOdlgCqNbEy8YrIhmnzbnGS1K/ZV8+koL0dJzHvMq7PHmZDRQaMnX6nq93RH49fteeA2OWLSU2pPOJa7IzNTkV64epTHKUKhMFwnrSI4oR38+EYinW0rCJtL0py+OPJTsufmzZQPtG8fDFkq9f5YB7SJ2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DAD14B6DE8;
	Mon,  2 Feb 2026 16:12:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D6D3E2000D;
	Mon,  2 Feb 2026 16:12:23 +0000 (UTC)
Date: Mon, 2 Feb 2026 11:12:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, mhiramat@kernel.org, andrii.nakryiko@gmail.com,
 linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
Message-ID: <20260202111249.649ac338@gandalf.local.home>
In-Reply-To: <20260202111548.3555306-3-dolinux.peng@gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-3-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D6D3E2000D
X-Stat-Signature: 9o6kf1qwyytgk8m1nwdxbf4u6ees7h4i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bJfcwbzvO8pG6DXOErSPkM9W7b3QU8fw=
X-HE-Tag: 1770048743-319643
X-HE-Meta: U2FsdGVkX186nfa8DJ30UUx9eW9kwwgvqQ5WqJkN79GuqtwQg4RnUCQuLRq4hRZYJIQkzUULZ61E0y4jMAk0X9og4nE7zx9lVK5Fq/nv0SksZEPhdr2HDbEWK6xNVBiThh1ik+/PNrag3DeAY0ATM8sbCDmnsU+nTVO/8UD7VUgUTYkmmlNbr9PYayHgRHr5a2aarPdA9ip48Cg9vrJPlI3v4EUeKQbLp4V3zaOGA+anElNovY4DdJh9sX0vkqVnNpAm6kbB3VtlnCwyik2FgQfSFrTOTUrpjIjYwRk1URcnYQYK0poy/8vdODkvEMo2Z6jnPMq8EHSiMBkCHiUhUfA8omQOIu6r

On Mon,  2 Feb 2026 19:15:48 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> @@ -754,6 +755,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  			break;
>  		case BTF_KIND_ENUM:
>  			trace_seq_printf(s, "%ld", arg);
> +			for_each_enum(i, t, enump) {
> +				if (arg == enump->val) {
> +					trace_seq_printf(s, " [%s]",
> +							 btf_name_by_offset(btf,
> +							 enump->name_off));
> +					break;
> +				}
> +			}
>  			break;

I have to ask; how big is that enum list?

Do we really want to do a linear search for every enum we come across?

What we could do is for the first time we hit an enum, create an array of
enums, sort them, and do a binary search from then on. This could be saved
in the tracing code itself (in kernel/trace/trace_btf.c), if BPF doesn't
care about it.

-- Steve
