Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572025;
	b=DHyU2qnzlkHK3+lZXrg9MVBED8WYCeV86d/a0iHjFbx35ZceAIjc17crNfPuF9kvaVt+
	 ome4rEhrjIIzs4mP4lSwLYP0E0b4vM+4iUuxBImmXhKjctphuAdPim/gQK2Y0pk42Ojcn
	 TlJZ7ShqulFyBKB4H/SgzXFnPmRt0x7ywEDO+dDJakYVh75cQjsa77FImRj7OHdsLdfbL
	 hHGX1EmuNOda5uuXyVuy5lNVLEihLHSePkta20yD7CYycfVgTGAgs5xmmQOKxEvVDsB1e
	 3pLN5emXbd+qvJjlAOCzTSqWDy5MIADB0dqAkiZ2RVWflIZPvN9qj0h3pErOgGXUnjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572025;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=HCkHPAtWU30r0NmD8QlJp1dvKMMkVesDoXjhGrW884Y=;
	b=onKA/P67XDk/gQ9xf0GFUUpZtH5DL4ySPGXk0AgCjsfS4YU2rvi+Kii33gj9azrLpm1v
	 1w9ckBI7oVFV79Oh3P7RLPvF72XfXmhFduSTCs4ZqKIjxXwF+X/YtCBSL4uWkwSrUvw2Q
	 9cQU02R1rhslbGtqUjKx+Fmshn7UdG+DmmNAKnXDpL0VlB7FHCfOgkA3x6cP/MurPAXAs
	 JF3mD8hbcK5OvGqzVCdGagdT1VCud3nKqGpQ5bYxCtFg73CjwWBBoTSccsi9GvuRaq5WA
	 7STXWS4vmqf73IEP7dA4vSBdXGzddKnZh0baXtJUMmDL28bBiCYL6ICadMma4gowu1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=C12TBuYA;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B8606A323;
	Wed, 25 Nov 2026 02:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E58B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=C12TBuYA
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 60C25A0E3F;
	Wed, 25 Nov 2026 02:00:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 302738000E;
	Wed, 25 Nov 2026 02:00:12 +0000 (UTC)
Date: Tue, 24 Nov 2026 21:00:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhang Yuwei <zhangyuwei20@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <iommu@lists.linux.dev>, <chenjun102@huawei.com>
Subject: Re: [PATCH] iommu: Trace I/O page fault response latency
Message-ID: <20261124210010.33da74d0@robin>
In-Reply-To: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
References: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 302738000E
X-Stat-Signature: srp7wme51mw49kdban6aew7ofc78rw91
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bYYI+Fc1f6TWv1w+Mh9sh3UC/ssQfDwU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HCkHPAtWU30r0NmD8QlJp1dvKMMkVesDoXjhGrW884Y=; b=C12TBuYAHZExlUMGANLERmsA4k127HTN9pttI+K8j3nDeyP5oEOzX5amU7XFI3gwnsf4WuV3izCvh0MJJzkG4h02+bhioY5U1tnDDljQEl4dYJrdB649YK4+aT2pJFyZ7m+DgZ7DKMQicHbxORJcNMseP4nkXgwHJxRT/bYJ3B8=
X-HE-Tag: 1795572012-190565
X-HE-Meta: U2FsdGVkX19eBoAF1h0SJOMEFwM0dJFMpeuhwwOJ1stJZBkt5Ud6cafI2JUFi6s55M05vZ9IjgTJXKfCaXrbrhFuPmfqKTfaIA0SEx71vwqIKHhEYdghC4AdPo5ZYOGwwOOlCRDccFTBxD9H/DN5AqMmDSjtqwLEnyavqunMyprIE6w+AjRrb0+VuFNmqzsqTMOig51wOyoo9bPSPVuqruACUl6ESpIHsCmnLfHJb9ZONBOfKSOqGKvsSb7D+82cwN0PkJNr92KtjIgngILJz6kpGIUbMh5rckp6g+e+0jIalJqoDlPa42R4vEenMz0ovN6gUndqEF7tgZlCTRph2gkbcI9XinU2

On Wed, 25 Nov 2026 09:34:30 +0800
Zhang Yuwei <zhangyuwei20@huawei.com> wrote:

> @@ -155,6 +159,14 @@ static struct iommu_attach_handle *find_fault_handler(struct device *dev,
>  	return attach_handle;
>  }
>  
> +static void iopf_trace_response(struct device *dev, const struct iopf_fault *evt,
> +				const struct iommu_page_response *resp)
> +{
> +	if (trace_iopf_latency_enabled() && evt->report_time_ns)
> +		trace_iopf_latency(dev, evt, resp,
> +				   ktime_get_ns() - evt->report_time_ns);

Please use:

		trace_call__iopf_latency(dev, evt, resp,
					 ktime_get_ns() - evt->report_time_ns);

As the trace_iopf_latency_enabled() already does check if the event is
enabled. Using the trace_call__ variant will always call the hooks
without adding another static branch.

-- Steve


> +}
> +
