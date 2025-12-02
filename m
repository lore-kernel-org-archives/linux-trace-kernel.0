Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB1215F7D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664355; cv=none; b=fEpd8XU4U4w9C/+CVn50Coxr3sLeLsSbBlYmJ/KBz+JgDCtbqyqQLKYJriMzX7jORdJ59T8WEpJlQzhosniskOmlBz+1vhHNr40GkxKGsnmr5EIXVj4F2qvfaKvqI3AKhCBpnwwt+HfzH/1QFUpecrFS/mGzZTI3Id9aPyY3jqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664355; c=relaxed/simple;
	bh=+2qSDsX0m0ywFzlJzvTEbNSgzwb7yQKligF5Ob/h4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IVwn+UfTNVqH7S15/5D4mu4AQtScf7QGv/Nfl+yuEv0M39KQmXKp+rvUYSpWHzoySn7PAGOi6U/72FBg81sJwJvp5kpDZid3iehF8AKMJ7lVx/dDYweyW4E8jQTlVTc40vxmQ7RqMNf1IOB5XQywHTYuDUQFIX5a9P7rO7sbeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+PKPZcl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+PKPZcl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso929373f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764664350; x=1765269150; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5cCUoPjwUlPXuiF+A+hn0lpFik3ndPGL8uzg07EIwg=;
        b=Z+PKPZclspogWV7qAguquE7T3WRgnke6EyOCTORpGUz0+112SFrUlgjNFyArUq6r4J
         dWCZIFCMpnMnntxeI7/y4MtG4RG/5ltfXgImqG6kiN8Uc7jItQSf6w9Tgp1PZEi32IgY
         GSbq3kqigIhELpLuBRNBO/nkS0LmgfERceR4Xs1/3uljIgMnnfiS7465rVaD0VLWnseF
         3tPm9b3dsCA0W3tXx9xe1u/LeI9izmsnvoUlwdCyIvq4t2Z/w/uftBUzxn3GHNaK+znW
         mxa9pjfUAHkcQol7uS5TwZ9bIQgrf8GAp7E8VLkn+JcS3b/3kUAOtj1QXzJk8/zQyee+
         /W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764664350; x=1765269150;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5cCUoPjwUlPXuiF+A+hn0lpFik3ndPGL8uzg07EIwg=;
        b=oGQJmgp4EBM3627C1pQQkG4HDu1s99/wLVLs0vjbwvQBhv2hf4h0ocH3VXwHT9c0w4
         3CnkMZxJ9zqob92p0cuMnhj6+Jry2gxnLj2fiJg+3idYe3XYE5xM1wKZf06eWzj1RE5H
         85JW0kaBfZnx8nzheI5F63CsGJiVO0WAhuxveqPd3PE0FMU12J2IcJjF9fb3jQKOfUaO
         xZkfsQzA4myYMEfXcIVyoEDwOBlMv+dof3UkBK7+3QypF6Nak2fZNKCpFO4sQ02SSK95
         QeV39B1Lq45pRjTWXuHygWw1fv1hfUbkL24GOgwiGX8J0MZv/e5iIdSedR6QnfTSfek0
         REDg==
X-Gm-Message-State: AOJu0YxaBuxrVlSufkfLxUL/ToMiIQ30UDCAzAWyzkv73Isb+ScGsQYG
	XrO+MafxaWk/wNSn8Us3Z1Z+NCuypoLpuCQsu+tdXkHiemnpuG5vYJ08E589N//HP6A=
X-Gm-Gg: ASbGnct9RVNgJmM5RPjIcjhqFjeL+ePfwgXbM2YiKPCc+G2O5nG1sB9qpPlFQKJ0raz
	GUzf9P+10hmTtPZnffxVeC7ilJdEg562MehvOQaCZNP5eBDeZKhsUQTml1LCEsHnAcAckOf6oW+
	puIpoogi6WpiE6sHce35bIQBac1DdVQxKicniYzhvSpuKJPPlqwhbOWgkU9FSCaatfJqwM8razQ
	HNgYB++rVip78+zINQaWRptQXMsIARNV48j4NNpaEC0gXWEsBP88s1PEv4zafOmNxgJ4nT9WCXc
	RA6XP2xXsHJ1NVw3e4AQ9inflhMP789j1XpKHmtMg/lzFGuHQS7ZDO326kd2ePHz9YPGl3Fb4pw
	LmTJF+fNBCURyMX3+tWwflEISMauls1qr/jwGoaZD9JNfI7f9djISvKKmE2iQQRctr1xc4F/kUX
	1mPV3CESooGvtchy07CwXKFq4lzQc=
X-Google-Smtp-Source: AGHT+IFwkf81/ZjrWR9rJM4ybPJvSy0qrGT8aXXqXSUj9qLiDb2LcgSz5oCr1fyZNplySmmiHJTa1Q==
X-Received: by 2002:a05:6000:1f03:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42cc1d2e2cemr34976525f8f.30.1764664350039;
        Tue, 02 Dec 2025 00:32:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca1a396sm31180615f8f.22.2025.12.02.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:32:29 -0800 (PST)
Date: Tue, 2 Dec 2025 11:32:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: pengdonglin <pengdonglin@xiaomi.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <aS6kGi0maWBl-MjZ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello pengdonglin,

Commit f83ac7544fbf ("function_graph: Enable funcgraph-args and
funcgraph-retaddr to work simultaneously") from Nov 25, 2025
(linux-next), leads to the following Smatch static checker warning:

kernel/trace/trace_functions_graph.c:1033 print_graph_entry_nested() warn: unsigned 'call->depth' is never less than zero.
kernel/trace/trace_functions_graph.c:975 print_graph_entry_leaf() warn: unsigned 'call->depth' is never less than zero.
kernel/trace/trace.h:1130 ftrace_graph_ignore_func() warn: unsigned 'trace->depth' is never less than zero.

kernel/trace/trace_functions_graph.c
    1012 static enum print_line_t
    1013 print_graph_entry_nested(struct trace_iterator *iter,
    1014                          struct ftrace_graph_ent_entry *entry,
    1015                          struct trace_seq *s, int cpu, u32 flags)
    1016 {
    1017         struct ftrace_graph_ent *call = &entry->graph_ent;
    1018         struct fgraph_data *data = iter->private;
    1019         struct trace_array *tr = iter->tr;
    1020         unsigned long func;
    1021         int args_size;
    1022         int i;
    1023 
    1024         if (data) {
    1025                 struct fgraph_cpu_data *cpu_data;
    1026                 int cpu = iter->cpu;
    1027 
    1028                 cpu_data = per_cpu_ptr(data->cpu_data, cpu);
    1029                 cpu_data->depth = call->depth;
    1030 
    1031                 /* Save this function pointer to see if the exit matches */
    1032                 if (call->depth < FTRACE_RETFUNC_DEPTH &&
--> 1033                     !WARN_ON_ONCE(call->depth < 0))
                                           ^^^^^^^^^^^^^^^
The patch changed call->depth from int to unsigned long.

    1034                         cpu_data->enter_funcs[call->depth] = call->func;
    1035         }
    1036 
    1037         /* No time */
    1038         print_graph_duration(tr, 0, s, flags | FLAGS_FILL_FULL);

regards,
dan carpenter
