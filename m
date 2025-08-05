Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4627F19B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408938; cv=none; b=mG2LElqqW5Z1e4AgaSsKOSHfl7p21B1ppsAflZOaoWqLjgkB6Q+SnVHO8n1IIRKTmeUqvkof1pyjHoTYbhorI1OfIdblLy5Pt+H2yDV2FkX7ytKQzapkIQZumHb6DmL3zv4bhbbtCKgojY+Mx0g2HTeKb1R1aQCNYqm8SDjJwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408938; c=relaxed/simple;
	bh=X2dfIZZ5Mq2RqlPfGxGJ4bSfulRv0axO5u2AT+yBECE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvVt7Ob7E+z7Dxc50Ces2Apt/2NNmbkVTaFjnwC4H0VFpMUFiNwpQB+YRv1cmTyGedFj3RU2R60fz7egd39xRDk/aGc8KR0DfunfNnLi5D3lbSf+ne3yMV16FjnZNkhrBR2kWk6ukqhvj7s0WsGrgDPncn8SifvdhDv2oGH+RO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgI9ANK2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgI9ANK2"
Message-ID: <4348a5c5-8689-49a8-b59f-bf4ab2bbc74b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2dfIZZ5Mq2RqlPfGxGJ4bSfulRv0axO5u2AT+yBECE=;
	b=AgI9ANK2dvdpxoFYlMskbC/MdROFC6Z8+fUVSU/pLKWFrXrBrM0kSG+OU3rc7IKb1YTI+4
	kZ9tuoe5njMBhmW4xumfuFoTCtt3ry2E4nektzKuP6rPaagoLAjQ2DwNMJq2WPWRhFTUaZ
	TnjE6NP0M8gqHz/7ysKBAepmQ6Rr5B4=
Date: Tue, 5 Aug 2025 08:48:47 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250805122312.1890951-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250805122312.1890951-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/5/25 5:23 AM, Tao Chen wrote:
> bpf program should run under migration disabled, kprobe_multi_link_prog_run
> called the way from graph tracer, which disables preemption in
> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
> need to use migrate_disable. As a result, some overhead maybe will be
> reduced.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

