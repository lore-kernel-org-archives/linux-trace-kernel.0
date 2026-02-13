Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C952E401;
	Fri, 13 Feb 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964468; cv=none; b=if3fQxUpwuc0jFkIRNfOUHxQknRKAvB/1zFad1UPKJGTgMlGjQnhcrQX1wD3gmzW3IcobGwg1sat+WcahDLH59F6xz1+Nx3TDZopaB+WPUS1lTP4mcJwZ8KkP0f27TfqmWViZreTOm1Yj47banvi4MtnFAaHCPIBpQ5MG3CJ9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964468; c=relaxed/simple;
	bh=Gu8f5/nmIEvZPVXBJiQdrc4ebHhH64bLw4Ly8YvTn1s=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=paVJPkONmlYzYXPVoze2atamaYwIUYL/Np5kXMbQADcHg8hH5lrBSLl7ClCOk9NHBDFgIgMuJt0Klpwwc7qA0g3SPXOf3eLzoAS4s3gSkRtB3L/bps5syU+qTAMQ+ZYg56LeE+g3OhMt7YYlyGuZYl9eW5GQPdUcN1kzf49aYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fC2Sv6PlLz7QYRD;
	Fri, 13 Feb 2026 14:34:23 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 61D6YGm7062599;
	Fri, 13 Feb 2026 14:34:16 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Feb 2026 14:34:18 +0800 (CST)
X-Zmail-TransId: 2afc698ec5ea0a8-2dbe8
X-Mailer: Zmail v1.0
Message-ID: <20260213143418061eqd7pIV5hJNyCoLCZtJ6R@zte.com.cn>
In-Reply-To: <20260212224752.4311a58d@fedora>
References: 202602131034245558BcmEI95X7Sr39QGM8YLl@zte.com.cn,20260212224752.4311a58d@fedora
Date: Fri, 13 Feb 2026 14:34:18 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZnVuY3Rpb25fZ3JhcGg6IHJlc3RvcmUgZGlyZWN0IG1vZGUgd2hlbiBjYWxsYmFja3MgZHJvcCB0byBvbmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 61D6YGm7062599
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 13 Feb 2026 14:34:23 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 698EC5EF.000/4fC2Sv6PlLz7QYRD

> On Fri, 13 Feb 2026 10:34:24 +0800 (CST)
> <hu.shengming@zte.com.cn> wrote:
> 
> > From: Shengming Hu <hu.shengming@zte.com.cn>
> > 
> > When registering a second fgraph callback, direct path is disabled
> > and array loop is used instead.
> > When ftrace_graph_active falls back to one, we try to re-enable direct
> > mode via ftrace_graph_enable_direct(true, ...).
> > But ftrace_graph_enable_direct() incorrectly disables the static key
> > rather than enabling it.
> > This leaves fgraph_do_direct permanently off after first multi-callback
> > transition, so direct fast mode is never restored.
> 
> Good catch!
> 
> > 
> > Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
> > Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> > ---
> > kernel/trace/fgraph.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index cc48d16be43e..4df766c690f9 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1303,7 +1303,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
> > static_call_update(fgraph_func, func);
> > static_call_update(fgraph_retfunc, retfunc);
> > if (enable_branch)
> > -       static_branch_disable(&fgraph_do_direct);
> > +       static_branch_enable(&fgraph_do_direct);
> > }
> 
> Your email client killed your patch. it has huge white-space damage.
> But because it's such a trivial change, I'll fix it up for you. But
> next time please make sure your email client doesn't corrupt your
> patches.
> 
> Thanks,
> 
> -- Steve

Hi Steve,
I’ve identified the cause of the email formatting issue and have resent the patch. 
https://lore.kernel.org/linux-trace-kernel/20260213142932519cuWSpEXeS4-UnCvNXnK2P@zte.com.cn/T/#u

Thank you very much for the reminder.

--
With Best Regards,
Shengming

> 
> > 
> > static void ftrace_graph_disable_direct(bool disable_branch)
> > --
> > 2.25.1
>
