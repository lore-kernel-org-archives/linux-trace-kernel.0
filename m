Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E73C5550;
	Thu,  2 Jul 2026 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033784; cv=none; b=PTTxcY+IUcgUQIroscmqRqiGHgMbss8/+oDKYlX0aLcAKe/FRUGd0UTVkRfGgWksAysedm9rYWIMWeCF17l6pW5owOf8uW85CPibv1+9vIb5WCTi0U/DXv2z6OonQRulZCufFAPW9VWyzI3Iktu+i//CjEn/z0+Zy+glxzNnWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033784; c=relaxed/simple;
	bh=FILav3yKKzpl28dd6CARNjyKZNqIjr35VEG1AuE24Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0x/KP+UaJJLzkYx8TKXoakiKNTIJgP+ED4h/uMEqRqFk4AiRWvTtD9oRSTpIo9lKknVYbXHeR7wKlco6+lBaqjLiAUMlwiB0SQDZcqK/+Gi0zR7L0R71+fAktBR5xZZ7K8VzE/WwFgw3TVDcPvHJR202dkNQYlTfxE37gXASlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7F3431A0375;
	Thu,  2 Jul 2026 23:09:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id F225D17;
	Thu,  2 Jul 2026 23:09:37 +0000 (UTC)
Date: Thu, 2 Jul 2026 19:09:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mukesh Kumar Savaliya
 <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya
 <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH 1/2] i2c: qcom-geni: trace: Add trace events for
 Qualcomm GENI I2C
Message-ID: <20260702190941.025263ee@gandalf.local.home>
In-Reply-To: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-1-474cd6cdbe27@oss.qualcomm.com>
References: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
	<20260630-add-tracepoints-for-qcom-geni-i2c-v1-1-474cd6cdbe27@oss.qualcomm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Stat-Signature: ndrfdqp7d6ubmh4dqhrb6sxg3ukoahfm
X-Rspamd-Queue-Id: F225D17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19zIaAEIPPEnTBW1NqooTxWNQaEVIgZXZQ=
X-HE-Tag: 1783033777-473480
X-HE-Meta: U2FsdGVkX19khEgBI/TvM4nV5UQFDxFhIfSdbasA7mlv3JD8KRlqUsQc6VfIBjWrrlI3ICGSBQIoMFJriTHjOC/NyfWUTXPUI0IiLhG6S2VJxhF3x7sqKdW1n87nHgq1YYLgkTwX6X78GyYUPjIo9VWAoJyL9H8XKmLCGh6NxCHT+AB2BVv5t9qdZX8slvrqNbC68n/nEaUH5KoaijbIHJ4XbstcBfiB/DfbL8Yznd/T4vo8T9j2xnBKOiRC9umcgSNT+Hh9XmyWnQrEP6FEEVIUgmuSGREgFxmrVo8gaClKSbRz8ZWJpN0kLBy79/LVACLTBQuvyFKmBsUnvtvXqtImurZ2QMsBviVUlZlNSg8MOos3B0L+UQB7KNIvL5xBIBdbxSoLF+V2jIbBfoOpSg==

On Tue, 30 Jun 2026 11:32:45 +0530
Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:

> Add trace event support to the Qualcomm GENI I2C driver to enable
> detailed runtime debugging and analysis.
> 
> The trace events capture I2C clock configuration, interrupt status
> and error code and message.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/include/trace/events/qcom_geni_i2c.h b/include/trace/events/qcom_geni_i2c.h
> new file mode 100644
> index 000000000000..c7e7984f3620
> --- /dev/null

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
