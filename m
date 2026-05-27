Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744D3F23B9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878808; cv=none; b=m8sdeJ3FJQFOWJsla2yl61IhUCmHxmlBZWmnXDKHMkTQYtk5B4qJ1C/TARgClDunA0Kk5h+KfYmj1QQYPCHpZ2y52KUWlj9QBSn9J+xpF4DsHDNExdZeXcxW37DbzXcWcP0XJlC9Edp7qj/rbO5PZzbG3S42jNhwPOOJPv28KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878808; c=relaxed/simple;
	bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhXpzzcrjnurXfE7Sc6QmHeM5jX1H2MLwVLthd1283s/TdcmOOOL0T4qdyzqaFpr0UkwN8nOkgPQfUBnPowoJkLiZtC+HkppZijRgO1UjXYFnvIXnVddvS3k122eY4ALt0OnceJJhUo2nZhKmeon8kjZKoZ4XZAyhSXOfJaGp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RS13JRPe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RS13JRPe"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bda62f13d90so1158903266b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779878805; x=1780483605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
        b=RS13JRPeaIxXK35VOd+U6mR84YFK7cckyHdZwjn5SsXcLMmPXpUr8YTH/7GA0H5aok
         H00tJKVfhKXsXo3y/EFLVN1KXhT+t5aye8C8DMW+S/HuJgwoYLSQ75bWCPeSxusnIYJ5
         UvDvps4yEYI3U1F51FCg5xqsOXj9mT6oA1on7eKus4dPeDtz935CVTM+1kxkHNaa8zyQ
         nYGswarxw2jT0pnGWcN+3+HC70F8In2wdhsTZg0ZCbY248vcnySu7G+jUzWZun/yp9jS
         5YMr1Mz0MtGszQ8gaKl3yPQpA0aKKTAAcAySXQQ7lGuIiIX/Z4sE0dD9b3rkpt2e8DW+
         pOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779878805; x=1780483605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
        b=F2yEdnbKKz4QWCmfgqDVDimriJdvoHytd6Spmc5nVe4dIpcleNZ0wmiuqfC6dnbwm7
         QoCrh6jQ2zua1wYzyBiSLQKf4lEdhipEKAFkI8Vhgp49EDCfm4+JGGNBFqOMiuNfTeh0
         ym2VfF7tJT3+tVS0CyQ5iuV5fs/0AyIztsM/Y9jIMXmc8ZGykssjee816mJhavDZP7n2
         mQ69h+SBmfqH05K9X5xEUyvcyLOIiR+L93C7Jyaec5jIaisrrqB5OC4R0dpw6ayKuR00
         YX5aicXovmNt+6DGtAUvY9NnYE1GldU0pKKEKoabelKKs7M+XDNjVF5wYAM4uJMbD9ND
         w5Zg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ojp0aTuEHRPQ39BOB1JN5vRK850H4KuCmNyYuTBhaMiDkSJEJVrSkBpb8PBvj3A/06rqV0Lh1JasBkNhGOv0WVnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKFPwGx3WSSKDkJJgE3bE5YDlPQ9oaw7NWIPl7dWhbNxGmrdR
	xLnpuZRlpyzA4OGs2tWITo997JYMQPYYOvcbtkcYetifZjdzjh+eumahG1TuNZ3P5xs=
X-Gm-Gg: Acq92OFLOAVYgWsJDHu8s7hHCogE1RUZxMrHHBcuLv3mWloTdBXmzF0Ew1/MsBcyNne
	lwf/yHaDGPO49Xs0QevjuBURgI50EOM6SyKqMnyvKW1orBtP2nPxGCWbBdqQjA+BqxzjsXTYU1O
	U3JrnzSLnxxakwrz6/oAooKjVbBAcHGi+Ys0XbRdM8woimhNqlwovbvyVpuxvVrTroYJbQtX8cY
	MoTXXWXrnq7dE8CFSgjQ5pxELy26qTHCc0/wCJ7k8pI+kI3jf2+jCGC1YCN7RwsRVz7NkKCSV7O
	uuLsUEhDK6npmMa7f53ci+blDPFhlC76LZ1EEkwQ1Kuz69SGkLSbf+YhqVBpAhYLYHX62ZAlh92
	N1Lek+rgUSVvMSrU3ijYuUgobd3aUnoEZWrU4XipLkcfc4lqbMq6eyqgZpWy1Yn3W2AL24VVCfa
	k+X+MInhqwQGGaUD4A32MOrBOtFA==
X-Received: by 2002:a17:906:9c9:b0:bcb:d9c7:c6f with SMTP id a640c23a62f3a-bdd22a454a7mr962061766b.7.1779878805241;
        Wed, 27 May 2026 03:46:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc6acc42csm589091966b.63.2026.05.27.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:46:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 10/13] selftests/bpf: Change uprobe/usdt trigger bench
 code to use nop10
In-Reply-To: <20260526205840.173790-11-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:37 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-11-jolsa@kernel.org>
Date: Wed, 27 May 2026 12:46:43 +0200
Message-ID: <87y0h55dv0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Changing uprobe/usdt trigger bench code to use nop10 instead
> of nop5. Also changing run_bench_uprobes.sh to use nop10 triggers.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
