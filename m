Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD51368296;
	Thu,  3 Sep 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459885; cv=none; b=nVgiF3m2WqLSsYVTW7rYtZ/EcDM6LUDthTC8FnizVJf+AIuQ/GS49hSA9IMRwrrl0QNRyMfApPAaT/c547s3Rf+WmUDWGJId75eruWkvgGksZr6Nd/SLDBQeNxAqM68cSdYygY8r2yEiTmKnS3K6nM3ntqm5VEZPZWc/s6nNL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459885; c=relaxed/simple;
	bh=wjx3yPgDYDk5VPpAVqnHcQzM+I8TVr46sYuOP7z5Nbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy7fjmX8SdPCOYOSNY4Vi39YGl/a5fIDiySqgSJ80i5H/eRg0Q1LMFVPucNLbDd9T39/J8Ybw48REsQzERhsc8cRi6vXxnuZW/wdPivWjZVECe4Vcpv3a9cu/bajz4udjz3UWlrQqJa4qRLUZAYHbDbNQLRgyD7mlVSBVh8sUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=6EjdColf; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="6EjdColf"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0D1A4C0657;
	Thu,  3 Sep 2026 18:24:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 51BE76000E;
	Thu,  3 Sep 2026 18:24:39 +0000 (UTC)
Date: Thu, 3 Sep 2026 14:25:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ftrace: Add checking nr_subbufs to persistent ring
 buffer  validation
Message-ID: <20260903142542.6d52bbc7@gandalf.local.home>
In-Reply-To: <20260903132728.7fb27d34@gandalf.local.home>
References: <20260903132728.7fb27d34@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51BE76000E
X-Stat-Signature: axu71bdxyi7yi5opsqqon9z1dy5onoq4
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/bCe+nxcZNw0Qjkaqgb+oXs/Nc+gCP3qg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=wjx3yPgDYDk5VPpAVqnHcQzM+I8TVr46sYuOP7z5Nbg=; b=6EjdColfPl7SIBztA+WNHDJPa057ltPYDRfEcZg3WNwf9DH16PCdmU+DFLGWbHD0H7q2t4GrPD62fgFYZOFq6h7QGVgF1SZi+xY3nsAwzj86dNENZ1pHVOAsJHOywgPNSA2kjjDv5e9BFp1xRqakuOwRFRsxiuWIK+7RxkHVC9o=
X-HE-Tag: 1788459879-502697
X-HE-Meta: U2FsdGVkX19I+QV3ZL3D1ivlKT11669oIEE4//g0F6/YH8zKJFXf8/2n2yjUvDSUXAyzkJPGhBhA1keO2FGM1hCUa2jkTviforfjElj6rSxBstLDbMqMS/QbjIImhuSFUA/MDLqNAWpTMlo+b4FtLCpd7Vl4KjIBB7fsefj5ll4bWwa6VZ4sqjMgVVdhhlbk0a8PSd3oLSpXCOwOYRPZQ85JPVWf8RpVu2MKL/5bh1CsKESanhkoKFIbLEqqaMg8qZNIr9o1mvrmpFeAvtdapVuE36K6692+Pqiv90NKDe6ig69KqZlK77uvVR9tPpKv


I just realized I used "ftrace:" and not "ring-buffer:". I'll apply it with
the updated subject.

-- Steve
