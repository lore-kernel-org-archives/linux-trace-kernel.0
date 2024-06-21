Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532516C879;
	Fri, 21 Jun 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959553; cv=none; b=QNSaUxdbjLxFf7wyX4s0GBGlK+cZ0eFcOLv1FnwJNvf+vg1weNuWZA8H57Gn4FnBAhQ9GqzsvwYjplb3gCbVKqKz1qKbtj33Ds4fM/UDY7Xq9aFmZXjNd03BnzUFjECZDRuqT21dD70JSC4FsPT0fldrWsIJ117yiIkDfimz/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959553; c=relaxed/simple;
	bh=Jm1CJOHyxYpfTBHmN9xn+udDaxS/UrcOrdDMaTOdTd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnbaT6+TvaTL+/W0+pLosy9AGpWLkHgmg7NAXqcBaoXT0II43Xghtn0Ir+w2CO/xqlQi/myIkExTRbmxrNFNE8y3MS31+JWg4PjE6ivRSX5nS4qxCDvet4//tQWbB4aB4E/I5TcP4j86wAJC+9qiPXEszbvcTn1g0lTHwpvCFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbq/7yuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbq/7yuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64479C4AF08;
	Fri, 21 Jun 2024 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959552;
	bh=Jm1CJOHyxYpfTBHmN9xn+udDaxS/UrcOrdDMaTOdTd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kbq/7yuOsmRNoRW8+gQqoTCScwozwP0ylwuBVW1xotQ5W+eSezjICa9t8A/Ospk2/
	 hCDNsNFXxRe5wL1p2lzkb/gsNFf81hNqql5abcboRCc1UJyxoxyjnuuzp75q8Z4IOl
	 cHXdarsxCen5QeoNZ7DQ+siC58ncqc2v4vT38IGbYktktsIg4Wb0m61kB4n5BHnxWu
	 AtBcl53AjVUIt/xpuy+L2tCI1aZdP5hnE8muLSgwlyXbn4kGlr+4Cn/u4vauGXGOxs
	 ddnkGlOkxA5meDQGWD3IDEeJzL29cenFYc8ygrtLXd7IhwhbtuWbzv0pLCqtN24KZe
	 5NYIv+DrAYp7w==
Message-ID: <9e4f976d-277e-41b3-9f32-943b2e8ddebc@kernel.org>
Date: Fri, 21 Jun 2024 10:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] rtla/timerlat: Add --disable-idle-states for top
To: tglozar@redhat.com, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, jwyatt@redhat.com
References: <20240612145439.206990-1-tglozar@redhat.com>
 <20240612145439.206990-4-tglozar@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240612145439.206990-4-tglozar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 16:54, tglozar@redhat.com wrote:
> @@ -550,6 +555,7 @@ static struct timerlat_top_params
>  			{"aa-only",		required_argument,	0, '5'},
>  			{"warm-up",		required_argument,	0, '6'},
>  			{"trace-buffer-size",	required_argument,	0, '7'},
> +			{"disable-idle-states",	no_argument,		0, '8'},

Can we add an argument with a state level to set?

>  			{0, 0, 0, 0}
>  		};
>  
> @@ -726,6 +732,9 @@ static struct timerlat_top_params
>  		case '7':
>  			params->buffer_size = get_llong_from_str(optarg);
>  			break;
> +		case '8':
> +			params->disable_idle_states = 1;
> +			break;
>  		default:
>  			timerlat_top_usage("Invalid option");
>  		}
> @@ -922,6 +931,7 @@ int timerlat_top_main(int argc, char *argv[])
>  	int return_value = 1;
>  	char *max_lat;
>  	int retval;
> +	int i;
>  
>  	params = timerlat_top_parse_args(argc, argv);
>  	if (!params)
> @@ -971,6 +981,21 @@ int timerlat_top_main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (params->disable_idle_states) {
> +		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
> +			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
> +				continue;
> +			if (save_cpu_idle_disable_state(i) < 0) {
> +				err_msg("Could not save cpu idle state.\n");
> +				goto out_free;
> +			}
> +			if (set_cpu_idle_disable_state(i, 1) < 0) {

and use the argument state here?                                    ^

-- Daniel

