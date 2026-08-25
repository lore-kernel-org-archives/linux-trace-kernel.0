Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F5346E75;
	Tue, 25 Aug 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622841; cv=none; b=n8bpNmLb6VscYa4qqm7mzG6j4k7y/lKpcpgOwydpCPOUo5AKPe97sq+2vH+b4r+p/F6Pth/wD0ob//mLhJgfbb34avuVh3I+tQt+9aWCzCoFgXXB7OaC8Cz1raqO2RsXBH2aejuHYg+Myzby+X/MRPIPnOtlmXAyHHbNHAlTuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622841; c=relaxed/simple;
	bh=rg3Kd+pkvxECtlvdCoSMguh9r9rC5vhQdZQo1+pCE1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd9zXUqFn9wetclxhA9oXpgYT70BrjyhiBn6vfS6jp2BX7tF4VA0B0CTYgyFpCL+/ZQZuZPXVRxfo5o6sz1//KlyP24N5+tVX68iWvrSXuNfosSwxnB0Wyk4G72LHNOfBLl1vscqHhOEyRaa40xoQJNtWpdASibnS2rnaDou86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=BtXIACoJ; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="BtXIACoJ"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 87ECDC01F1;
	Tue, 25 Aug 2026 01:53:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 7C31735;
	Tue, 25 Aug 2026 01:53:55 +0000 (UTC)
Date: Mon, 24 Aug 2026 21:53:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tz.stoyanov@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix use-after-free in trace_pipe read on
 sub-buffer order change
Message-ID: <20260824215354.22142bd4@fedora>
In-Reply-To: <CADhLXY4t+qgESW4ZPOVtOfsOGcBcwiM=BRnhngMBKvb8R7MemA@mail.gmail.com>
References: <20260817140655.5694-1-kartikey406@gmail.com>
	<CADhLXY4t+qgESW4ZPOVtOfsOGcBcwiM=BRnhngMBKvb8R7MemA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7C31735
X-Stat-Signature: k5higfqmu788cs9kmbw3ppg1xzwtq3mr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18bX9oUhStltEcLR3s6mBKIrIsSBi2lEOc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Gw2yrio/TOuesBHk5S3gLche0D7GMl8O1Dru7DLXG7g=; b=BtXIACoJAHlR08+XqrqO3TUGRJa17dNOUdUAYzM/IOx61cSnNaZqP5aQU5sQASZ4lhSK3dIz67bT+5Vsp8Zp7EEUNzbSYxGoFE1j07pn/yhC87zaCyjqvTsO49Elcm3f5UFKOjvfk7VJC+y8rFIAfTRwSKOIYVEvHithEFLnArE=
X-HE-Tag: 1787622835-118348
X-HE-Meta: U2FsdGVkX18AKoEDJbgsf/2LquGe543UM4hKQNjmBgXhm/+TJvMGggOv9D7xP3/tTSWQEPqvuKYaOjzDDPmXr7e2iwOiWJBQFhRj7iBBa56cqnfbU/bniclQLdSAsaXVwPBnEI3Yuppns5u6gJ8SJ2M+aKmWBDMVu4rrtDpex5MNzGZS0qupfwcnQ5+WqM9sq+rHEKs/Bj6kluOSUvKwlv4EXEPVZe9vjNI9dRUNKA3I/VH5goKl2ZQ2eEEXOXDmggWFWcrj7mj3TkI0qZhXmQ0WrhlENPJ5kjgBnmOA0jA0siakGLsI23sF67eUuXaOBRG7FY2jrOn1E/a/9DP6d9/2FoynjMtQQSLOxN+Mf4q/Y5TBWmA4VA==

On Tue, 25 Aug 2026 06:58:29 +0530
Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> On Mon, Aug 17, 2026 at 7:37=E2=80=AFPM Deepanshu Kartikey

You just sent this 6 days ago, and you likely got my out-of-office
message.

> <kartikey406@gmail.com> wrote:

>=20
> Gentle Reminder. Please let me know the status of this patch

Check patchwork for status:

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20260817140=
655.5694-1-kartikey406@gmail.com/

-- Steve
