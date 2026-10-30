Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325339;
	b=AHeBEGINSFAUCRUd+GnumXYzQtWrTsTLESjuJolCp7dUZtfkORycg75WKgmVQyBFxCUk
	 FIfE7AO/jgJnHUbGR0CMc9AxMM5kRCoktinYKPanq8iqlqb/plLaxZvSaW2xcz89l/vp9
	 DsPyKZd6awBIjeKFht3Lh/kJLG+nPtkaalxMoRMocFhr85zrp/924vMersI32Zf9gPzpQ
	 6uyUrbiuj/XvuoFGOpbubfSx4wapGVD7fi801w21S19zVZJTHj/WxXQZMDONJJgmD6BvG
	 OAzDKytMofkgKNBTfIUrtcMNkwfDhZEVGPypGjdMKRh7FFuceQiBgrvnylbFaj9mesQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325339;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NW47OZGG+imSFWQTUojgxKaRsVA/dxTDAH6Z79eqPk4=;
	b=XKF+PA0YHUCzDOeWDfonQJ0BpDJ6aimDU1K8Dk8LzanUDF+Po6CJGhSUutmcbIUpd3bI
	 Np0aykM/BWKYX38aunxinKXNk3B5QiyRuntEgXraBSLPbPYZFyGNZgNgz+aF3iuP0eLV8
	 3a7eLWsMemS84EprtFlcbdH1xv7lDvW0VxTLf/q1EZHZq5xc/tZB05gU7DYjK/6+ONsGZ
	 cLu7hKjzdzzeOvtzCD3uHeMs/MMYqQmvbXz687GDVL5bGRoscHuY9FJOk86yoclxQnw9G
	 jUTHoFRSRU4FZ9x+Q9G+XOKbAQ3CTpdTVCRlfsPg9xfxsoGayKVBMJV2ru23JjtokDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tJinQgl7;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B27606A322
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 01:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B27606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tJinQgl7
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yLibGXRg0x614xy7jj1umLLnLSoSQ8rxXuFtkSyAjTw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793325336; v=1; x=1793930136;
 b=tJinQgl73cr3AUsCPm6B+YtFCqmb7GEy7gRNXN1Ncvnor1T3bPpjZNMlreCZ6Im6e2wSkI1F
 twibpD/2a6cx4UBL8xznzC7Rj5gmRvDynXTyjbjomOjWdixbUPIYb78y5hd4XRCHD5ujWxUOz/x
 SG3SuSCSmmfttwXvvbeosLaM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e53ba925bba0fe2;
	Fri, 30 Oct 2026 01:55:29 +0000
X-Mizu-Trace-ID: 6e53ba925bba0fe2
X-Migadu-Flow: FLOW_OUT
Message-ID: <96dfb9b7-1eaf-4bb2-8136-9a2478e1a068@linux.dev>
Date: Fri, 30 Oct 2026 09:55:17 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for
 bpf_link_create
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Masashi Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261026154948.99408-1-leon.hwang@linux.dev>
 <20261026154948.99408-6-leon.hwang@linux.dev>
 <CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/10/26 00:22, Andrii Nakryiko wrote:
> On Mon, Oct 26, 2026 at 8:51 AM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>> @@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
>>                         return libbpf_err(-EINVAL);
>>                 break;
>>         default:
>> -               if (!OPTS_ZEROED(opts, flags))
>> +               if (!OPTS_ZEROED(opts, iter_info_len))
> 
> semantically cleaner would be to use log_opts here instead of
> iter_info_len, send in a follow up?

Will do.

> 
>>                         return libbpf_err(-EINVAL);
>>                 break;
>>         }
>>  proceed:
>> -       fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
>> +       fd = __sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz, log_opts);
>>         if (fd >= 0)
>>                 return fd;
>>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
>> @@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
>>         if (err != -EINVAL)
>>                 return libbpf_err(err);
>>
>> +       /* bpf_raw_tracepoint_open() does not support log_opts */
>> +       if (log_opts)
>> +               return libbpf_err(err);
>> +
>>         /* if user used features not supported by
>>          * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
>>          */
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 826d9cc9ab65..fe3b7fd8512b 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
>>  struct bpf_link_create_opts {
>>         size_t sz; /* size of this struct for forward/backward compatibility */
>>         __u32 flags;
>> -       union bpf_iter_link_info *iter_info;
>> +       union {
>> +               union bpf_iter_link_info *iter_info;
>> +               struct bpf_log_opts *log_opts;
>> +       };
>>         __u32 iter_info_len;
> 
> in a follow up, let's add comment next to iter_info above and
> iter_info_len here that these are deprecated and that iter.info and
> iter.info_len should be used instead
> 
Will add comment when adding log_opts support for BPF_TRACE_ITER in
libbpf in near future.

Thanks,
Leon

