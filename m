Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6A2DF152;
	Tue,  2 Sep 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842604; cv=none; b=S7112C3HOhk95oruSMe12AdizSFGl/rjhkJeFxQqr58QNHy/drGGcWoZqEoQYzZiB5/GbX6UTnyhGMxUeOqVWTj7Oil+KCTjPvVsxIZs6n/OKXDkW1KPikfUE29F9+vupXAaIKEJc4McXMi1HgsmlECEg8QEj1/vnnI491PSQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842604; c=relaxed/simple;
	bh=NdufQxzOZlWguBL9HwYXkIGe7xQ4IfzTq08st8ba+Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdZUrEil8BzQZLiWODhYAjmRmn4reXTbRvJ0BOZu1FOOEhEl5/MFTJNmdCg7Fv0jzqV/V6N8WwAgZo/NMwJp7zXfas44B4yqMLEIdOu1p+Pq/GMAkt4wAcylj5hrX16T9motKcpJlUtL+8FL/MeARJxc4yYWj18BeLqDHqsp8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E5862160383;
	Tue,  2 Sep 2025 19:49:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 5553E20013;
	Tue,  2 Sep 2025 19:49:58 +0000 (UTC)
Date: Tue, 2 Sep 2025 15:49:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
Cc: <mhiramat@kernel.org>, <dhowells@redhat.com>, <wsa@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: Fix OOB access in
 trace_event_raw_event_smbus_write
Message-ID: <20250902154957.7987e5ff@batman.local.home>
In-Reply-To: <20250821012312.3591166-1-zhangxiaomeng13@huawei.com>
References: <20250821012312.3591166-1-zhangxiaomeng13@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5553E20013
X-Stat-Signature: mg7mrwaidbnnetu8tc6mdrjs59sgswc9
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+w6D8sT48f7HfE0tYL7qw3Yp0RncEh3AU=
X-HE-Tag: 1756842598-367105
X-HE-Meta: U2FsdGVkX1/Zwox4elp08vAurhM9a+8r1ZwMgqON4QB5V13NJBjg0ybR29Es+nnnph0YcG/ZrMJeqWcup+0ELcBGfqbbKPVH0Le9RruIdDrzFn8dTa3/JcMpBD2sNbVB3aIigB6YxdO5Jl4zJNteoF5i12/xLo6Ncpnko8/l45jR6YZawOQnNkMibbdqDlGWgGSmaZ8skhDZi0VhgoXrh6AE9QWUwQtHXI0qNC5FhQEq4FKouCKl5J7zWIsmzc8cGjWw7TbGSgb4YuAr3JijjSkg+mucQOvH77G+dGfxVcYRl/aPg+g10ZDJfbgTOOi4xu8CAgh1RPR9umFXWgHlnHXGVkZs+M5U

On Thu, 21 Aug 2025 01:23:12 +0000
Xiaomeng Zhang <zhangxiaomeng13@huawei.com> wrote:

> The smbus_write tracepoint copies __entry->len bytes into a fixed
> I2C_SMBUS_BLOCK_MAX + 2 buffer. Oversized lengths (e.g., 46)
> exceed the destination and over-read the source buffer, triggering
> OOB warning:
> 
> memcpy: detected field-spanning write (size 48) of single field
> "entry->buf" at include/trace/events/smbus.h:60 (size 34)
> 
> Clamp the copy size to I2C_SMBUS_BLOCK_MAX + 2 before memcpy().
> This only affects tracing and does not change I2C transfer behavior.
> 
> Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ver #2]")
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>  include/trace/events/smbus.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> index 71a87edfc46d..e306d8b928c3 100644
> --- a/include/trace/events/smbus.h
> +++ b/include/trace/events/smbus.h
> @@ -57,6 +57,8 @@ TRACE_EVENT_CONDITION(smbus_write,
>  		case I2C_SMBUS_I2C_BLOCK_DATA:
>  			__entry->len = data->block[0] + 1;
>  		copy:
> +			if (__entry->len > I2C_SMBUS_BLOCK_MAX + 2)
> +				__entry->len = I2C_SMBUS_BLOCK_MAX + 2;
>  			memcpy(__entry->buf, data->block, __entry->len);
>  			break;
>  		case I2C_SMBUS_QUICK:

The code has:

                switch (protocol) {
                case I2C_SMBUS_BYTE_DATA:
                        __entry->len = 1;
                        goto copy;
                case I2C_SMBUS_WORD_DATA:
                case I2C_SMBUS_PROC_CALL:
                        __entry->len = 2;
                        goto copy;
                case I2C_SMBUS_BLOCK_DATA:
                case I2C_SMBUS_BLOCK_PROC_CALL:
                case I2C_SMBUS_I2C_BLOCK_DATA:
                        __entry->len = data->block[0] + 1;
                copy:   
                        memcpy(__entry->buf, data->block, __entry->len);
                        break;
                case I2C_SMBUS_QUICK:
                case I2C_SMBUS_BYTE:
                case I2C_SMBUS_I2C_BLOCK_BROKEN:
                default:
                        __entry->len = 0;
                }

I only see two calls to the copy where one is len = 1 and the other is
len = 2. Why not put the check before the copy label?

-- Steve
