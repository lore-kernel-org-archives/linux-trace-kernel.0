Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4B47206E;
	Fri, 16 Oct 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162058; cv=none; b=kZs0nx6RCU3i3pIvpA8/BGXrEOmTsuxR5JZ7oZRxfiCco1MXlbuJ1D344NLh+qLP60Lq2F24X/lv0MG2liahFXFyTrExj6qFwIbeNRP+PMVgkiYtCGZ1ss9feDrRe+/oMbS6otJJFgTHxJhPXZn1I94DUTfMs0YDA59i0dTS6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162058; c=relaxed/simple;
	bh=0eYAq26iIVtciEHX2DSVOJjAkKPQK9qaG5mIUMKR55U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jMuqRwpD0f64ZlY42hkNwul4K4VStX3+34L3wdZ4ln09CLKuInKc0iwGY5nhDvuIQDDhMf/fWdk5tJ8vcTezH4uJXpeIoZRd3SByxNw/9E7Sso3ATKTn22ZTMurRiltlqz1zoccGhauFKRRbXOtVaKM14nkD6+eSEvoHNcKefPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=aRTNrOzV; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="aRTNrOzV"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 979AC1D1B;
	Fri, 16 Oct 2026 14:48:17 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=aRTNrOzV;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B864C1D4B;
	Fri, 16 Oct 2026 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1792162047;
	bh=DvjT2Gj2UIKbNYOGUZeX2UqIeeYbC4C0qDY5UdUlqP0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aRTNrOzVYa3gengcQq1AdEoI1O4YsAXrEYGybzGZnjnLZH1LO2sDHsoR26/fiNvfE
	 Zq+D+h2ed6dcVt65M6AQ27hxMOY653LLi9TT1YGbn3+zULHc2lpDQeK1wkuFXG3Akn
	 Tj4EvhbEBFEyXEnUKlRjoVoaTqxNYcXcC2MaMHZk=
Received: from [192.168.95.128] (172.30.20.132) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Oct 2026 17:47:25 +0300
Message-ID: <b271b809-b310-40f5-aaca-c4f43927cd68@paragon-software.com>
Date: Fri, 16 Oct 2026 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] ntfs3: add tracepoints for core filesystem paths
To: Baolin Liu <liubaolin12138@163.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
	<linux-trace-kernel@vger.kernel.org>, <liubaolin12138@gmail.com>, Baolin Liu
	<liubaolin@kylinos.cn>
References: <20260820090504.950475-1-liubaolin12138@163.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260820090504.950475-1-liubaolin12138@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 8/20/26 11:04, Baolin Liu wrote:

> From: Baolin Liu <liubaolin@kylinos.cn>
>
> This series adds an initial set of tracepoints for ntfs3 core paths.
>
> The tracepoints cover:
>     - mount and log replay
>     - namei operations
>     - directory index operations
>     - allocation and block mapping
>     - iomap operations
>     - file I/O entry points
>
> Changes in v4 (both addressing review comments on patch 5):
>     - ntfs3_attr_data_get_block: pass the "new" pointer to the trace
>       event directly and move the "new != NULL" check into
>       TP_fast_assign(), keeping that logic out of the call site and only
>       executed when the event is enabled
>     - ntfs3_attr_set_size_ex: stop sampling the old size with
>       i_size_read() in TP_fast_assign() - on the truncate path
>       truncate_setsize() has already updated i_size to the new value, so
>       the recorded old_size always equaled new_size. Read the actual old
>       size from the on-disk attribute record and pass it as an explicit
>       parameter; move the call site after the attribute lookup so both
>       resident and non-resident attributes are covered
>
> Baolin Liu (7):
>    ntfs3: add mount and log replay tracepoints
>    ntfs3: add namei tracepoints
>    ntfs3: add create inode tracepoint
>    ntfs3: add directory index tracepoints
>    ntfs3: add allocation tracepoints
>    ntfs3: add iomap tracepoints
>    ntfs3: add file I/O tracepoints
>
>   MAINTAINERS                  |   1 +
>   fs/ntfs3/attrib.c            |  12 ++
>   fs/ntfs3/dir.c               |   3 +
>   fs/ntfs3/file.c              |   5 +
>   fs/ntfs3/fslog.c             |   3 +
>   fs/ntfs3/index.c             |   8 +
>   fs/ntfs3/inode.c             |   7 +
>   fs/ntfs3/namei.c             |   5 +
>   fs/ntfs3/super.c             |  11 +-
>   include/trace/events/ntfs3.h | 389 +++++++++++++++++++++++++++++++++++
>   10 files changed, 443 insertions(+), 1 deletion(-)
>   create mode 100644 include/trace/events/ntfs3.h

Hello,

Your patches were applied, thank you.

Regards,
Konstantin

