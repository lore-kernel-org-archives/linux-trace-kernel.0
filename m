Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84C472559
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836517; cv=none; b=DVZZhGZEbXFMhlpXz10YeSNMcD5C1xkHsWrc2LbEfJL7481B+ybqD/kfWsUyRKizfIn5vRVDTOvcsigXR74wAp0BK6pjkRRHMxHBTvPKX6plhTT7SsZQ8ayfCKY0wsq4CVy5srQ1Mum3omIUqxYS6C4RdMcnBYEZXSQNf8pUFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836517; c=relaxed/simple;
	bh=jR4mRqs32IUcI/m/KbwQ7Vym5B+Z9w2bM9qUGSorNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7gHFrUu1AG+p1J6lH7v6bLKxT8lbGosZvLHJg+UdlYJcSwNw91/xY8NnBnCKsU9oAc0Ahlb9NhPQZfKIDZTIojNnHPAVmdaoa4zbIFnLSa45p7iCTa85WaxRDWd0jdOSM/aERC/OCfgL6ilWOEnFPTbtM6R5H5ctBz0/c8J+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=NCvWKzhD; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="NCvWKzhD"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AEC85C024A;
	Thu, 27 Aug 2026 13:14:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id F35216000A;
	Thu, 27 Aug 2026 13:14:53 +0000 (UTC)
Date: Thu, 27 Aug 2026 09:15:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260827091541.5d03e33c@gandalf.local.home>
In-Reply-To: <ao_Zu0ThaWThj9YZ@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
	<20260826094528.3738023-2-vdonnefort@google.com>
	<20260826095947.4FF8B1F000E9@smtp.kernel.org>
	<20260826103736.2b55b464@gandalf.local.home>
	<ao8TQ-SvhjYgy43-@google.com>
	<20260826143123.1b3e3854@gandalf.local.home>
	<ao_Zu0ThaWThj9YZ@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F35216000A
X-Stat-Signature: finf3sszcgs4ra44k5w4fxt1pd3g9mnb
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8bBjpjX1rb7w6M/De5rieedWYuH6n+gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4rx+Jukd69U71oXhkK+4brjCaBl56wc/fNZAnDqZX4M=; b=NCvWKzhD8HeIKPFs/HWTNtoXZVkZn3mAZ3k1SngPrwLQzmKhcxRRIsiVR+bw14uo5zUN4b9ip4Vy0SFVCfH9plKBICCEYVmt3jIMYlQGXPSI+zRqH0L5KvlWMCN6UAHOguNLvkdi5rD7Z+EJABkLzvnKwj29sW5IRK9v7GvqsqE=
X-HE-Tag: 1787836493-618963
X-HE-Meta: U2FsdGVkX19EkAXce3d40tLst0oN3wPKZV7hunF6l4RG3LT5ud9ihlYhdwzfHiK0aRQ10BPDP5CUR9PpH8vNPWN2Ki+B8uLm555FF0fjhS9QvTtPHu1XJCWLJSFQvRPF8F7wro7PkXaQ0kSU9XdO7Mxdd1qXxpk0dkaTqFCVHSu8tqHyuI55+fSKAZZCx+T316qWz9ksfYOEEPXWux6iGgR6rJLsFvKKgB7N1LdNa5+2J0U9AMI8Prsq9aATnT/BaLk4NGpye16WI7nSHxONpXqHcKgXQqYwfGq92iwN02lJ8XBrrEqv2DnbH3l6X6aogqyTSfGzDZHKNYqUa5nOoL8g3LoSJyfATGBHarzwo8ULJ9lTCYT0sQ==

On Thu, 27 Aug 2026 07:31:23 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Looking at the function again, shouldn't we add !rb_is_static(cpu_buffer) as
> well to the full page test?

Why? 

-- Steve
