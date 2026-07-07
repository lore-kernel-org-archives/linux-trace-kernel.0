Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43923417343;
	Tue,  7 Jul 2026 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430554; cv=none; b=pg8e8gEaTK1ad//rbfsfQ8vLCwQ0DUUkz9mwF36+WNHb7LOJsNZtTvYpplgNNB4WuLBgLyeyKk0PTzHLIsu89LAsL1+9eqRUqVbkgo19peWXHVkaS8GQQ0/HzbEcdI3JnuCvag70Y68hR9+NgyOugBug3E7w3aUyxAdykjlYTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430554; c=relaxed/simple;
	bh=MGVmYeYxnpIZcpOw+7f6zRYjrLjUCebAKwtJF/haJZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyMHzINfk73EOvTFkfGdF9Pieo4/UcQJ+8Kry/1VzRlDm3xDdXqSU9nC0iQlQn3zOA++cN6XuYaJYa0GMNy2ZFXST9CCsv1+RDAf+KhNFGw8HTSFggtHwGpaTqtZQs9iJ8leGHVAawe+GvL8iQPoHP9H06RYVkyowFUYSd2Bc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e391489c7a0611f1aa26b74ffac11d73-20260707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:768afa27-d69f-4861-9ecd-a33b4ba39268,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b1607e6a3c30be20adfcda1aae37fd2f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e391489c7a0611f1aa26b74ffac11d73-20260707
X-User: pengyu@kylinos.cn
Received: from [192.168.31.66] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 382878980; Tue, 07 Jul 2026 21:22:23 +0800
Message-ID: <852e911a-d18b-455c-a1cf-720f224349cd@kylinos.cn>
Date: Tue, 7 Jul 2026 21:22:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracing/synthetic: Free type string on error path
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603062533.1096320-1-pengyu@kylinos.cn>
 <20260603062533.1096320-2-pengyu@kylinos.cn>
 <20260706131534.70e602ef@gandalf.local.home>
From: Yu Peng <pengyu@kylinos.cn>
In-Reply-To: <20260706131534.70e602ef@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/2026 1:15 AM, Steven Rostedt wrote:

> Can you do this instead?
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index cdd5b9332835..7ff0f00edbdd 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -828,7 +828,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>   	} else if (size == 0) {
>   		if (synth_field_is_string(field->type) ||
>   		    synth_field_is_stack(field->type)) {
> -			char *type;
> +			char *type __free(kfree) = NULL;
>   
>   			len = sizeof("__data_loc ") + strlen(field->type) + 1;
>   			type = kzalloc(len, GFP_KERNEL);
> @@ -844,7 +844,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>   			s.buffer[s.len] = '\0';
>   
>   			kfree(field->type);
> -			field->type = type;
> +			field->type = no_free_ptr(type);
>   
>   			field->is_dynamic = true;
>   			size = sizeof(u64);
> 
> -- Steve

Yes, that looks better. I'll fold it into v2.

Thanks,
Yu Peng
