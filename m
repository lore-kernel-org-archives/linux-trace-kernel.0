Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A842FDC28;
	Wed, 29 Jul 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320509; cv=none; b=FZd29pJrCsf24fUK67ekmtCE4L5fZp7T4Go5Px/qHw3RQgO9u+EgRiAudh0CezFFx323jjMI3sMJBjjMIiWrZVr5q+wagAl3zajfnxlIq0Q7Od0jNlWXfT8OhrvfREqmIvay9XqYUOVhWrWo+VUhxsxs7WtrccB6EQuWq6Hw6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320509; c=relaxed/simple;
	bh=Zbp+zBfZJfVeaygQWtWMqiY+gl3qT1JrScU/lq6U7Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfcBZ5iqyvuAKmB7dhx2dlEqDJBoqwPFE4G2k6Povnv7my8vPgdpgRW9XJyvMI+ERtC//QhHJxLoRMAdFo5jDcwxN3MVgIkRNJzjeHzqcDX1tIa5bGtP30vSHE5fp2nvZ+LXS5Mq/I5c916p5irFZzyVWKCIEykxHKHguwl5bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=B7DQNWFR; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="B7DQNWFR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zbp+zBfZJfVeaygQWtWMqiY+gl3qT1JrScU/lq6U7Ec=; b=B7DQNWFRDfQH61qNpphDevX+dT
	o4HjnbsQrmKANyXCz+QQ+3PyKe4TLtnjWu+nask+36bpLrG5JPYEBUWRZ1TJHdkVR5A5aCYbSUsGp
	XKUDLhluRjyO39VVwY3PpMD54VAWuVonhQWbLoTczgvsxpigibwzsbaTJTMwVNv2n2AHR+5F9bn5c
	XyYRwWYbs8KkuNlmqeOZalOfLeHErp+vDwktRPm4TbN81Gl6aUC/ueoRln4gZ/Dohdy0IXzIGe/lM
	BiNcVGU3jAUTgBLqp02QOGz5RJpgd3krb2VXrMlMpzVpP6cS30gU4q5KwJY+IDN/AViAH8R3bmaAE
	G7cgiXvw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp1Pu-008NmQ-00;
	Wed, 29 Jul 2026 10:21:38 +0000
Date: Wed, 29 Jul 2026 03:21:31 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <amnTfwagJQpEY_21@gmail.com>
References: <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
 <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
 <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
 <amh1nZVVaaZSGD3M@gmail.com>
 <20260728122016.30752d36c3b3c3af231efa9d@linux-foundation.org>
 <44f81bea-d64a-4f73-8665-46652a928c83@kernel.org>
 <amkn21ftNme48Vbl@gmail.com>
 <f83d5b26-b369-489b-a305-1eb5ec6fccfb@kernel.org>
 <amm72Bu9qmWLI-9b@gmail.com>
 <d0d62d7d-8701-4692-89b9-84dff71a7cf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d62d7d-8701-4692-89b9-84dff71a7cf0@kernel.org>
X-Debian-User: leitao

On Wed, Jul 29, 2026 at 11:09:11AM +0200, David Hildenbrand (Arm) wrote:
> Avoid bash scripts, please :)

Sorry, I will try to control my fingers next time.

Jokes aside, all the selftests I maintain
(tools/testing/selftests/drivers/net/netconsole) were done in bash, so,
I got totally biased.
