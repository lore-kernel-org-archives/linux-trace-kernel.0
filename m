Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1437DABC;
	Wed,  9 Sep 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975646; cv=none; b=QIEFr/4WotVLdXK2pdmBtF5NVVW+LGydaCWLTB+mnl5mOTg+OpmdWqgLqrKXj0d8/Utaly8cIeTzM5N5GiD5HQDjXRDuPRIErMLzj65HD+nz4iT4nNmhdWq0VMs3KdA9VGkN430mxailEi5d2xRUvGxOQIpOmW06s2e+X0XrR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975646; c=relaxed/simple;
	bh=vOPyrWVi6qqE7sYvrSwJa8RgdfKrzdkdQpU53OStgZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfQS/oo9WdbZUbAPbQcljVMxLUQAiFYggbK1TpZiYEQpj8++mBFj8ZT4nc0x+RVHez5AjT/nQSVE8evCNMQftPxN3fkaG/nV1rDlUqFDduQY91vuq04LH9bMwuGrVJRSmjSiAY44Gz8pvsCteUbJ9HXJkP/xPmjK5ichzzl+bxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=JaopRl5H; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="JaopRl5H"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4251B1402CD;
	Wed,  9 Sep 2026 17:40:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3CD3741;
	Wed,  9 Sep 2026 17:40:40 +0000 (UTC)
Date: Wed, 9 Sep 2026 13:41:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix unique symbol check in
 kprobe_non_uniq_symbol.tc
Message-ID: <20260909134156.6425e8b0@gandalf.local.home>
In-Reply-To: <20260909092954.2200558-1-svens@linux.ibm.com>
References: <20260909092954.2200558-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nbdht7udeopfaonmwdpqtri7st73s5k3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3CD3741
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+wuuizAZRrBrnyHyxgaQYOxQm3npG6WN4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=k61UOLUWtwxb1LR5yESkPyq61Z+yxGwDgikexfhecXQ=; b=JaopRl5H1fOGQJARN6rJSGOCV1e10YwV5nTNJEVEZg0RapgQMD2cEAoV25W3xhQCnibWyPHn9MAm8UaBz1Ja4p8gBm0leLSFiUwqKa89Dj+DANbM2AKxZOKSc927XrS396RxasM1y9Kuqj0kiOcKrSth2xPplfLHE7I/GRcs3l0=
X-HE-Tag: 1788975640-759811
X-HE-Meta: U2FsdGVkX19n25FivK7oKhLguDDUNlMMVkgUg5KTF61fe3HFxSzHstYk+2jBwlusxRCXNnjix7NnadiJPLATtUUZLsVctJ1Za63yZBUyooeEmyuCEt5P93Vep6hdZp/RIDKIYbzFfImGn+A3u9qwTczNJ9ylEa3yukgXuU6yHLEOwbjisz9yeY11hauz7d05GyEFAurr4Ycd44xowUHtpST0GrhXs13yd232utl60ULUOzYqAYzg5DnvRHr/Oxc1t/D3RJ+jWDEyQP4TInauUsCmAZlbnAY7FI1hSh13l4+KTFds9I+B9Z4m4KKFzUYoq2Ag687ifm+6J1ZDbRYslc6UqGahn1hPJy6qVtJCaULLLv9eysur5lcQ9fSOuUAqjKkm3l/tNeU/gGwJ/aFBXg==

On Wed,  9 Sep 2026 11:29:53 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> The current regex also matches symbols in modules, which makes the
> test fail on s390 where name_show is present only once in the kernel,
> but also multiple times in modules:
> 
> 000001b1401cdc20 t name_show
> 000001b0c05e6c40 t name_show    [mdev]
> 000001b0c0495f30 t name_show    [i2c_core]
> 
> Fix this by changing the regular expression to only match the function
> name.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> index bc9514428dba..07b1177c1634 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> @@ -6,7 +6,7 @@
>  SYMBOL='name_show'
>  
>  # We skip this test on kernel where SYMBOL is unique or does not exist.
> -if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
> +if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
>  	exit_unsupported
>  fi
>  

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

But I wonder if "type_show" or "init_once" is a better option than
"name_show"?

-- Steve
