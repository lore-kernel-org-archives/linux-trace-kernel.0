Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA93D4132;
	Mon,  8 Jun 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937481; cv=none; b=sez0qcAuvVQ1t99zc3oLM8Km2TKHk8u8xBQdM3xu6NtgVM+GotsjePThw+T5VqPs9Y/GrPcR7lpVwFKpzPkOOy/pvBgEyCStYurO4jUBzlmdpjT/YT6GCGlAAP8z7EQyKAvpWa5GiDsXrk/4GawAFhkBoP+LJULKrZzWZ1A9qO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937481; c=relaxed/simple;
	bh=dvw4B0MFUGhQsaCJAWHJ57mhwnuAYBzXUK8+E7P+HII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5vaQO8fnhVU2eBdmUBPlYzQq/yO4MV+vfkFqgnra4xFvgsAv6HEjzxr5y9YsL0p0sP/HxKcKjUp8zCs3q+I0Pg7jSgyGvHOILXj8RLsFcxllgTt3C8fkOtpmhS0w5w7A8I5vSbTSD46QlhNEpbxDqxraZoUNNBcE+F11RbqOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id BE9551C146F;
	Mon,  8 Jun 2026 16:51:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id F026A6000C;
	Mon,  8 Jun 2026 16:51:03 +0000 (UTC)
Date: Mon, 8 Jun 2026 12:50:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Account for 8-byte aligned
 trace_marker_raw events
Message-ID: <20260608125049.092d4543@fedora>
In-Reply-To: <20260607072431.125633-3-hui.wang@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
	<20260607072431.125633-3-hui.wang@canonical.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n69aa6z4jurymeyti9gr6ra78987gknd
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: F026A6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+24W3c8CWHBr6zX27ioqSedKHmpq1RU6I=
X-HE-Tag: 1780937463-703503
X-HE-Meta: U2FsdGVkX196H5grzkMWc47i0gFRr0d7p9d4jZ8hur9FlIHsmAkqc595qqaDFfj0+m8TS2XiRph5Q5YmMcHYsk209IRTzy4qXbWQ/4Q9J+4MKd48wdE6TXTCJlnAtazs1ellKOIC3iVeqBPh3lCKWx+1ppJYuHKLTiLeehx7UO5UR2PlqCLfocBm6xEod+gymbfeiZYwHlzQ9qkvFFPAgGAUk683c6LIRdUarS+pgmi24YQmEurXLupIWcgOUvybA8PKLyQqOsoEfMzM53/tbX7crymmr33alZ1n7PxyMzYHHvKiKS/AdN78hFsu+WG5OVXJ4FB9vEDGajWp1S5EUaCVQdXRd08JQSHUNbYEmRgwUeXhmzQuBpgeNZr1G1IWKP061pWgLcgfc05jY7iAFLoAYByb9+c/3XdGKTofgPo=

On Sun,  7 Jun 2026 15:24:31 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> trace_marker_raw.tc assumes that the raw marker payload length
> reported in trace_pipe is the result of int((id + 3) / 4) * 4, but
> that is not true on kernels with CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> enabled.
> 
> With forced 8-byte alignment, the ring buffer event forces 8-byte
> alignment. The event length is stored in array[0], the payload data
> and id are placed in a struct raw_data_entry which is stored starting
> at array[1]. In this case, the printed payload data length is 8*N+4
> bytes.
> 
> To make the testcase pass in this case, add a kconfig_enabled() helper
> and use it to detect CONFIG_HAVE_64BIT_ALIGNED_ACCESS so
> trace_marker_raw.tc can calculate the expected length correctly.
> 
> Assisted-by: Copilot:gpt-5.5
> Signed-off-by: Hui Wang <hui.wang@canonical.com>

NACK

Let's not change the kernel for a broken test. Also this has already
been fixed but appears not to be applied yet.

Shuah, can you please apply the below fix.

  https://lore.kernel.org/all/20260601023251.1916483-1-dtcccc@linux.alibaba.com/

-- Steve

