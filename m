Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECB3C1D5E;
	Mon, 31 Aug 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173558; cv=none; b=Xyu0c+QBnro6bWiVFmtRLMcahDFpJMkaRyYonbWBtVPXKjAhIMMlFUxD6/m3xgDB/6YuAO6dQv40l6jV1sozcdS52FASSxqk8BpwtmleOegQGb4rz3finEzm0DzdWvPVwz7jGJgnv4CVoCOmwPLHgJr5RbGs0k49o+ByM+3uuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173558; c=relaxed/simple;
	bh=qjM/GxnKhKNrSTJmWHUVBpoIQVFVykC91BkkYvfAUJg=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ctpxmq7purW0tsd62tlHWYSa0JEPQLLCXslDhlzKVcjpr2CyGoFP5nIFYVVtND9TZDJF3hngGjPta8oEXa9o4+MiW6e551PXDMPUubXuCK4BVD5ISUL6yR9B/sKWU4hQo3TvkWH4y5nlXAwxrv3jjR7y93Y6M0xOYipcNsvW9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hYQmw5ymbz8Xrrc;
	Mon, 31 Aug 2026 18:52:32 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 67VAqRZn020435;
	Mon, 31 Aug 2026 18:52:27 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 31 Aug 2026 18:52:29 +0800 (CST)
X-Zmail-TransId: 2afb6a955ced449-8ee1a
X-Mailer: Zmail v1.0
Message-ID: <20260831185229820QtPvU0In3o2wLbCelSO_8@zte.com.cn>
In-Reply-To: <a61aa866-f95a-42fa-86d8-86f0726e0d00@infradead.org>
References: 20260830191258354QN6qx13iCRbQd2Uj3Ve2s@zte.com.cn,a61aa866-f95a-42fa-86d8-86f0726e0d00@infradead.org
Date: Mon, 31 Aug 2026 18:52:29 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rdunlap@infradead.org>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <skhan@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggNC80XSBEb2N1bWVudGF0aW9uL2Z0cmFjZTogRG9jdW1lbnQgZnVuY3Rpb24gY29tbSBmaWx0ZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67VAqRZn020435
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 31 Aug 2026 18:52:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A955CF0.002/4hYQmw5ymbz8Xrrc

Randy wrote:
> Hi,
> 

Hi Randy,

> On 8/30/26 4:12 AM, hu.shengming@zte.com.cn wrote:
> > From: Shengming Hu <hu.shengming@zte.com.cn>
> > 
> > Document set_ftrace_comm and set_ftrace_notrace_comm, including their
> > write and O_TRUNC behavior, accepted comm names, interaction with PID
> > filters, and when a task is rechecked after its comm changes.
> > 
> > Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> > ---
> >  Documentation/trace/ftrace.rst | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 7261f25f8b4b..a96fc436ec16 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -313,6 +313,37 @@ of ftrace. Here is a list of some of the key files:
> >          If a PID is in both this file and "set_ftrace_pid", then this
> >          file takes precedence, and the thread will not be traced.
> > 
> > +  set_ftrace_comm:
> > +
> > +    Have the function and function_graph tracers trace only threads whose
> > +    task comm is listed in this file. Names are matched exactly and must
> > +    contain between 1 and TASK_COMM_LEN - 1 bytes.
> > +
> > +    Each write adds one name. A single trailing newline is ignored, while
> > +    embedded newlines are rejected. A zero-length write or a write containing
> > +    only a newline adds no entry. Duplicate entries have no effect.
> > +
> > +    Opening the file with O_TRUNC clears the filter. Otherwise, writes add
> 
> Is there a way to clear the filter from (in) a shell script?
> 

Yes. It can be cleared with:

  # echo > set_ftrace_comm

The shell opens the file with O_TRUNC, which clears the existing filter.

I described the O_TRUNC behavior but overlooked the corresponding
user-facing shell command. Thanks for pointing this out.

Based on Masami's feedback, I am now considering reworking the series
around a generic event trigger that updates set_ftrace_pid, so the
comm-specific files may not remain in the next version.

--
With Best Regards,
Shengming
